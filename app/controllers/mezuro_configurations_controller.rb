include OwnershipAuthentication

class MezuroConfigurationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :mezuro_configuration_owner?, only: [:edit, :update, :destroy]

  # GET /mezuro_configurations/new
  def new
    @mezuro_configuration = MezuroConfiguration.new
  end

  # GET /mezuro_configurations
  # GET /mezuro_configurations.json
  def index
    @mezuro_configurations = MezuroConfiguration.all
  end

  # POST /mezuro_configurations
  # POST /mezuro_configurations.json
  def create
    @mezuro_configuration = MezuroConfiguration.new(mezuro_configuration_params)
    respond_to do |format|
      create_and_redir(format)
    end
  end

  # GET /mezuro_configurations/1
  # GET /mezuro_configurations/1.json
  def show
    set_mezuro_configuration
    @mezuro_configuration_metric_configurations = @mezuro_configuration.metric_configurations
  end

  # GET /mezuro_configurations/1/edit
  # GET /mezuro_configurations/1/edit.json
  def edit
    set_mezuro_configuration
  end


  def update
    set_mezuro_configuration
    if @mezuro_configuration.update(mezuro_configuration_params)
      redirect_to(mezuro_configuration_path(@mezuro_configuration.id))
    else
      render "edit"
    end
  end

  # DELETE /mezuro_configurations/1
  # DELETE /mezuro_configurations/1.json
  def destroy
    set_mezuro_configuration
    current_user.mezuro_configuration_ownerships.find_by_mezuro_configuration_id(@mezuro_configuration.id).destroy
    @mezuro_configuration.destroy
    respond_to do |format|
      format.html { redirect_to mezuro_configurations_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_mezuro_configuration
    @mezuro_configuration = MezuroConfiguration.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def mezuro_configuration_params
    params[:mezuro_configuration]
  end

  # Extracted code from create action
  def create_and_redir(format)
    if @mezuro_configuration.save
      current_user.mezuro_configuration_ownerships.create mezuro_configuration_id: @mezuro_configuration.id

      format.html { redirect_to mezuro_configuration_path(@mezuro_configuration.id), notice: 'mezuro configuration was successfully created.' }
      format.json { render action: 'show', status: :created, location: @mezuro_configuration }
    else
      format.html { render action: 'new' }
      format.json { render json: @mezuro_configuration.errors, status: :unprocessable_entity }
    end
  end
end
