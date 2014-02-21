include OwnershipAuthentication
include MetricConfigurationsConcern

class CompoundMetricConfigurationsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :mezuro_configuration_owner?, only: [:new, :create]
  before_action :metric_configuration_owner?, only: [:edit, :update]
  before_action :set_metric_configuration, only: [:show, :edit, :update]
  before_action :set_metric_configurations, only: [:new, :edit]
  
  # GET mezuro_configurations/1/compound_metric_configurations/new
  def new
    @compound_metric_configuration = MetricConfiguration.new
    @compound_metric_configuration.configuration_id = params[:mezuro_configuration_id].to_i
  end

  def create
    @compound_metric_configuration = MetricConfiguration.new(metric_configuration_params)
    @compound_metric_configuration.configuration_id = params[:mezuro_configuration_id].to_i
    @compound_metric_configuration.metric.compound = true
    respond_to do |format|
      create_and_redir(format)
    end
  end

  def show
    @compound_metric_configuration = @metric_configuration
    @reading_group = ReadingGroup.find(@compound_metric_configuration.reading_group_id)
    @compound_metric_configuration.configuration_id = params[:mezuro_configuration_id].to_i
  end

  def edit
    @compound_metric_configuration = @metric_configuration
    @compound_metric_configuration.configuration_id = params[:mezuro_configuration_id].to_i
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def metric_configuration_params
    params[:metric_configuration]
  end

  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    @mezuro_configuration_id = params[:mezuro_configuration_id]

    set_metric_configurations
    format.html { render action: destiny_action }
    format.json { render json: @compound_metric_configuration.errors, status: :unprocessable_entity }
  end

  #Code extracted from create action
  def create_and_redir(format)
    if @compound_metric_configuration.save
      format.html { redirect_to mezuro_configuration_path(@compound_metric_configuration.configuration_id), notice: 'Compound Metric Configuration was successfully created.' }
    else
      failed_action(format, 'new')
    end
  end

  def set_metric_configurations
    @metric_configurations = MetricConfiguration.metric_configurations_of(params[:mezuro_configuration_id].to_i)
  end

end