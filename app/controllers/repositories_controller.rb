class RepositoriesController < ApplicationController
  before_action :set_repository, only: [:show, :edit, :update, :destroy]

  # GET /repositories
  # GET /repositories.json
  def index
    @project = Project.find(params[:project_id])
    @repositories = Repository.repositories_of(params[:project_id])
  end

  # GET /repositories/1
  # GET /repositories/1.json
  def show
     @project = Project.find(params[:project_id])
  end

  # GET projects/1/repositories/new
  def new
     @project = Project.find(params[:project_id])
     @repository = Repository.new
  end

  # GET /repositories/1/edit
  def edit
    @project = Project.find(params[:project_id])
  end

  # POST /repositories
  # POST /repositories.json
  def create
    @project = Project.find(params[:project_id])
    #@repository = @project.repositories.create(params[:repository].permit(:name, :type, :address, :configuration_id))

    @repository = Repository.new(repository_params)

    @repository.project_id = @project.id

    respond_to do |format|
      if @repository.save
        format.html { redirect_to project_path(@project), notice: 'Repository was successfully created.' }
        format.json { render action: 'show', status: :created, location: @repository }
      else
        format.html { render action: 'new' }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repositories/1
  # PATCH/PUT /repositories/1.json
  def update
    respond_to do |format|
      if @repository.update(repository_params)
        format.html { redirect_to @repository, notice: 'Repository was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @repository.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repositories/1
  # DELETE /repositories/1.json
  def destroy
    @repository.destroy
    respond_to do |format|
      format.html { redirect_to repositories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repository
      @repository = Repository.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repository_params
      params.require(:repository).permit(:name, :configuration_id, :address, :type)
    end
end
