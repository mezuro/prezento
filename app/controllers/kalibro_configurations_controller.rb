include OwnershipAuthentication

class KalibroConfigurationsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :kalibro_configuration_owner?, only: [:edit, :update, :destroy]

  # GET /kalibro_configurations/new
  def new
    @kalibro_configuration = KalibroConfiguration.new
    @attributes = @kalibro_configuration.attributes
  end

  # GET /kalibro_configurations
  # GET /kalibro_configurations.json
  def index
    @kalibro_configurations = KalibroConfiguration.public_or_owned_by_user(current_user)
  end

  # POST /kalibro_configurations
  # POST /kalibro_configurations.json
  def create
    @kalibro_configuration = KalibroConfiguration.new(kalibro_configuration_params)
    respond_to do |format|
      create_and_redir(format)
    end
  end

  # GET /kalibro_configurations/1
  # GET /kalibro_configurations/1.json
  def show
    set_kalibro_configuration
    Rails.cache.fetch("#{@kalibro_configuration.id}_metric_configurations") do
       @kalibro_configuration.metric_configurations
    end
  end

  # GET /kalibro_configurations/1/edit
  # GET /kalibro_configurations/1/edit.json
  def edit
    set_kalibro_configuration
    @attributes = @kalibro_configuration.attributes
  end


  def update
    set_kalibro_configuration
    if @kalibro_configuration.update(kalibro_configuration_params)
      redirect_to(kalibro_configuration_path(@kalibro_configuration.id))
    else
      render "edit"
    end
  end

  # DELETE /kalibro_configurations/1
  # DELETE /kalibro_configurations/1.json
  def destroy
    set_kalibro_configuration
    current_user.kalibro_configuration_attributes.find_by_kalibro_configuration_id!(@kalibro_configuration.id).destroy
    @kalibro_configuration.destroy
    respond_to do |format|
      format.html { redirect_to kalibro_configurations_url }
      format.json { head :no_content }
    end
    Rails.cache.delete("#{@kalibro_configuration.id}_metrics")
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_kalibro_configuration
    @kalibro_configuration = KalibroConfiguration.find(params[:id].to_i)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def kalibro_configuration_params
    params[:kalibro_configuration][:name].strip!
    params[:kalibro_configuration]
  end

  # Extracted code from create action
  def create_and_redir(format)
    if @kalibro_configuration.save
      current_user.kalibro_configuration_attributes.create kalibro_configuration_id: @kalibro_configuration.id

      format.html { redirect_to kalibro_configuration_path(@kalibro_configuration.id), notice: t('successfully_created', :record => @kalibro_configuration.model_name.human) }
      format.json { render action: 'show', status: :created, location: @kalibro_configuration }
    else
      format.html { render action: 'new' }
      format.json { render json: @kalibro_configuration.kalibro_errors, status: :unprocessable_entity }
    end
  end
end
