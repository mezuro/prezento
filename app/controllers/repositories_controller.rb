require 'webhooks'

include OwnershipAuthentication

class RepositoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :state, :state_with_date, :index, :notify_push]
  before_action :project_owner?, only: [:new, :create], unless: Proc.new { params[:project_id].nil? }
  before_action :repository_owner?, only: [:edit, :update, :destroy, :process_repository]
  before_action :set_repository, only: [:show, :edit, :update, :destroy, :state, :state_with_date, :process_repository,
                                        :notify_push]
  before_action :set_project_id_repository_types_and_configurations, only: [:new, :edit]

  # Gitlab can't send a CSRF token, don't require one
  skip_before_action :verify_authenticity_token, :only => [:notify_push]

  def index
    @repositories = Repository.public_or_owned_by_user(current_user)
  end

  # GET /projects/1/repositories/1
  # GET /projects/1/repositories/1.json
  # GET /projects/1/repositories/1/modules/1
  # GET /projects/1/repositories/1/modules/1.json
  def show
    set_kalibro_configuration
  end

  # GET projects/1/repositories/new
  def new
    @repository = Repository.new
  end

  # GET /repositories/1/edit
  def edit; end

  # POST /projects/1/repositories
  # POST /projects/1/repositories.json
  def create
    @repository = Repository.new(repository_params)
    respond_to do |format|
      create_and_redir(format)
    end
  end

  # PUT /projects/1/repositories/1
  # PUT /projects/1/repositories/1.json
  def update
    respond_to do |format|
      if @repository.update(repository_params)
        format.html { redirect_to(repository_path(@repository.id), notice: t('successfully_updated', :record => t(@repository.class))) }
        format.json { head :no_content }
      else
        failed_action(format, 'edit')
      end
    end
  end

  # DELETE /projects/1/repositories/1
  # DELETE /projects/1/repositories/1.json
  def destroy
    @repository.destroy
    respond_to do |format|
      format.html { redirect_to projects_path }
      format.json { head :no_content }
    end
  end

  # POST /projects/1/repositories/1/state
  def state
    if params[:last_state] != 'READY'
      @processing = @repository.last_processing

      respond_to_processing_state
    else
      head :ok, :content_type => 'text/html' # Just don't do anything
    end
  end

  # POST /projects/1/repositories/1/state_with_date
  def state_with_date
    year, month, day = params[:year], params[:month], params[:day]
    @processing = @repository.processing_with_date("#{year}-#{month}-#{day}")

    respond_to_processing_state
  end

  # GET /projects/1/repositories/1/process
  def process_repository
    @repository.process
    set_kalibro_configuration
    respond_to do |format|
      format.html { redirect_to repository_path(@repository.id) }
    end
  end

  def branches
    branch_params = branches_params
    branches_list = Repository.branches(branch_params[:url], branch_params[:scm_type])

    respond_to do |format|
      format.json { render json: branches_list }
    end
  end

  def notify_push
    hook_info = Webhooks::GitLab.new(request, @repository)
    if hook_info.valid_request?
      if hook_info.valid_address?
        if hook_info.valid_branch?
          @repository.cancel_processing_of_repository unless %w(READY ERROR).include? @repository.last_processing_state
          @repository.process
        end

        render nothing: true, status: :ok
      else
        render nothing: true, status: :forbidden
      end
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private
  def set_project_id_repository_types_and_configurations
    @project_id = params[:project_id]
    @repository_types = Repository.repository_types
    @configurations = KalibroConfiguration.public_or_owned_by_user(current_user).map { |conf|
      [conf.name, conf.id]
    }
  end

  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    set_project_id_repository_types_and_configurations

    format.html { render action: destiny_action }
    format.json { render json: @repository.errors, status: :unprocessable_entity }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_repository
    @repository = Repository.find(params[:id].to_i)
  end

  def set_kalibro_configuration
    if @repository
      @kalibro_configuration = KalibroConfiguration.find(@repository.kalibro_configuration_id)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def repository_params
    params[:repository][:name].strip!
    params[:repository][:address].strip!
    params[:repository][:project_id] = params[:project_id] if params.key? :project_id
    params[:repository]
  end

  def branches_params
    params.permit(:scm_type, :url)
  end

  # Code extracted from create action
  def create_and_redir(format)
    if @repository.save
      current_user.repository_attributes.create(repository_id: @repository.id)
      format.html { redirect_to repository_process_path(@repository.id), notice: t('successfully_created', :record => t(@repository.class)) }
    else
      failed_action(format, 'new')
    end
  end

  def respond_to_processing_state
    respond_to do |format|
      if @processing.state == 'READY'
        format.js { render action: 'load_ready_processing' }
      elsif @processing.state == 'ERROR'
        format.js { render action: 'load_error' }
      else
        format.js { render action: 'reload_processing' }
      end
    end
  end
end
