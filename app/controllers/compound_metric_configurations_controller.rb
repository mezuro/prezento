class CompoundMetricConfigurationsController < BaseMetricConfigurationsController
  METRIC_TYPE = 'CompoundMetricSnapshot'

  before_action :set_metric_configurations, only: [:new, :edit]

  protected

  def set_metric!
    @metric_configuration.metric.type = 'CompoundMetricSnapshot'
  end

  def metric_configuration_params
    params.require(:metric_configuration).permit(:reading_group_id, :weight, :metric => [:name, :description, :script, :scope, :code])
  end

  def set_metric_configurations
    @metric_configurations = MetricConfiguration.metric_configurations_of(@kalibro_configuration.id)
  end
end
