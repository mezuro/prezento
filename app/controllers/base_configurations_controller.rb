include OwnershipAuthentication
include MetricConfigurationsConcern

class BaseConfigurationsController < ApplicationController

	def new
    update_metric_configuration(MetricConfiguration.new)
    metric_configuration.configuration_id = params[:mezuro_configuration_id].to_i
  end

  def show
    @reading_group = ReadingGroup.find(metric_configuration.reading_group_id)
    @mezuro_ranges = metric_configuration.mezuro_ranges
    metric_configuration.configuration_id = params[:mezuro_configuration_id].to_i
  end

  def create
    update_metric_configuration(MetricConfiguration.new(metric_configuration_params))
    metric_configuration.configuration_id = params[:mezuro_configuration_id].to_i
  end

  protected

  def metric_configuration
  	raise "SubclassResponsibility";
	end

  def update_metric_configuration (new_metric_configuration)
  	raise "SubclassResponsibility";
	end

  # Never trust parameters from the scary internet, only allow the white list through.
  # TODO: this should be refactored to the concern metric configuration
  def metric_configuration_params
    params[:metric_configuration]
  end
end