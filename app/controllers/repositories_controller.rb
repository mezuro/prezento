include OwnershipAuthentication
include ResourceFinder

class RepositoriesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :state, :state_with_date]
  before_action :project_owner?, only: [:new, :create]
  before_action :repository_owner?, only: [:edit, :update, :destroy, :process_repository]
  before_action :set_repository, only: [:show, :edit, :update, :destroy, :state, :state_with_date, :process_repository]

  # GET /projects/1/repositories/1
  # GET /projects/1/repositories/1.json
  # GET /projects/1/repositories/1/modules/1
  # GET /projects/1/repositories/1/modules/1.json
  def show
    set_kalibro_configuration
  end

  # GET projects/1/repositories/new
  def new
    @project_id = params[:project_id]
    @repository = Repository.new
    @repository_types = Repository.repository_types
  end

  # GET /repositories/1/edit
  def edit
    @project_id = params[:project_id]
    @repository_types = Repository.repository_types
  end

  # POST /projects/1/repositories
  # POST /projects/1/repositories.json
  def create
    @repository = Repository.new(repository_params)
    @repository.project_id = params[:project_id]
    respond_to do |format|
      create_and_redir(format)
    end
  end

  # PUT /projects/1/repositories/1
  # PUT /projects/1/repositories/1.json
  def update
    respond_to do |format|
      if @repository.update(repository_params)
        format.html { redirect_to(project_repository_path(params[:project_id], @repository.id), notice: t('successfully_updated', :record => t(@repository.class))) }
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
      format.html { redirect_to project_path(params[:project_id]) }
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
    @processing = Processing.processing_with_date_of(@repository.id, "#{year}-#{month}-#{day}")

    respond_to_processing_state
  end

  # GET /projects/1/repositories/1/process
  def process_repository
    @repository.process
    set_kalibro_configuration
    respond_to do |format|
      format.html { redirect_to project_repository_path(@repository.project_id, @repository.id) }
    end
  end

private
  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    @project_id = params[:project_id]
    @repository_types = Repository.repository_types

    format.html { render action: destiny_action }
    format.json { render json: @repository.errors, status: :unprocessable_entity }
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_repository
    @repository = find_resource(Repository, params[:id].to_i)
  end

  def set_kalibro_configuration
    @kalibro_configuration = KalibroConfiguration.find(@repository.kalibro_configuration_id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def repository_params
    params[:repository][:name].strip!
    params[:repository][:address].strip!
    params[:repository]
  end

  # Code extracted from create action
  def create_and_redir(format)
    if @repository.save
      format.html { redirect_to project_repository_process_path(@repository.project_id, @repository.id), notice: t('successfully_created', :record => t(@repository.class)) }
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
