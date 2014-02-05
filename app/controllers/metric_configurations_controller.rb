include OwnershipAuthentication

class MetricConfigurationsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :mezuro_configuration_owner?, except: [:show]
       
  def new
    @mezuro_configuration_id = params[:mezuro_configuration_id].to_i
    @metric_configuration = MetricConfiguration.new
  end

  def create
    @metric_configuration = MetricConfiguration.new(metric_configuration_params)
    @metric_configuration.configuration_id = params[:mezuro_configuration_id].to_i
    respond_to do |format|
      create_and_redir(format)
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def metric_configuration_params
    params[:metric_configuration]
  end

  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    @mezuro_configuration_id = params[:mezuro_configuration_id]

    format.html { render action: destiny_action }
    format.json { render json: @metric_configuration.errors, status: :unprocessable_entity }
  end

  #Code extracted from create action
  def create_and_redir(format)
    if @metric_configuration.save
      format.html { redirect_to mezuro_configuration_path(@metric_configuration.configuration_id), notice: 'Metric Configuration was successfully created.' }
    else
      failed_action(format, 'new')
    end
  end
end