include OwnershipAuthentication

class ProjectsController < ApplicationController
  before_action :authenticate_user!,
    except: [:index, :show]
  before_action :project_owner?, only: [:edit, :update, :destroy]

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.public_or_owned_by_user(current_user)
  end

  # POST /projects
  # POST /projects.json
  def create
    image_url = project_params.delete(:image_url)
    @project = Project.new(project_params)
    respond_to do |format|
      create_and_redir(format)
      @project.attributes.update(image_url: image_url) unless @project.attributes.nil?
    end
  end

  # GET /project/1
  # GET /project/1.json
  def show
    set_project
    @project_repositories = @project.repositories if @project.is_a?(Project)
  end

  # GET /projects/1/edit
  # GET /projects/1/edit.json
  def edit
    set_project
  end

  def update
    set_project
    image_url = project_params.delete(:image_url)
    if @project.update(project_params) && @project.attributes.update(image_url: image_url)
      redirect_to(project_path(@project.id))
    else
      render "edit"
    end
  end

  # DELETE /project/1
  # DELETE /project/1.json
  def destroy
    set_project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id].to_i)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params[:project][:name].strip!
    params[:project]
  end

  # Extracted code from create action
  def create_and_redir(format)
    if @project.save
      current_user.project_attributes.create(project_id: @project.id)
      format.html { redirect_to project_path(@project.id), notice: t('successfully_created', :record => t(@project.class.name)) }
      format.json { render action: 'show', status: :created, location: @project }
    else
      format.html { render action: 'new' }
      format.json { render json: @project.likeno_errors, status: :unprocessable_entity }
    end
  end
end
