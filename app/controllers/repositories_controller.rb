include OwnershipAuthentication

class RepositoriesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_repository, only: [:show, :edit, :update, :destroy]
  before_action :check_repository_ownership, except: [:show]
  after_action :process_respository, only: :create

  # GET /projects/1/repositories/1
  # GET /projects/1/repositories/1.json
  # GET /projects/1/repositories/1/modules/1
  # GET /projects/1/repositories/1/modules/1.json
  def show
    @configuration = KalibroEntities::Entities::Configuration.find(@repository.configuration_id) #FIXME: As soon as the Configuration model gets created refactor this!
    @processing = @repository.last_processing
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
        format.html { redirect_to(project_repository_path(params[:project_id], @repository.id), notice: 'Repository was successfully updated.') }
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
    @repository = Repository.find(params[:id].to_i)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def repository_params
    params[:repository]
  end

  # Start to process a repository
  def process_respository
    @repository.process if @repository.persisted?
  end

  # Code extracted from create action
  def create_and_redir(format)
    if @repository.save
      format.html { redirect_to project_path(params[:project_id]), notice: 'Repository was successfully created.' }
      format.json { render action: 'show', status: :created, location: @repository }
    else
      failed_action(format, 'new')
    end
  end
end
