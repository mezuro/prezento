class CompoundMetricConfigurationsController < BaseMetricConfigurationsController
  ALLOWED_METRIC_TYPES = %w(NativeMetricSnapshot CompoundMetricSnapshot)

  before_action :set_metric_configurations, only: [:new, :edit]

  protected

  def set_metric!
    @metric_configuration.metric.type = self.metric_type
  end

  def metric_configuration_params
    params.require(:metric_configuration).permit(:reading_group_id, :weight, :metric => [:name, :description, :script, :code, :scope => [:type]])
  end

  def allowed_metric_configurations(kalibro_configuration_id)
    MetricConfiguration.metric_configurations_of(kalibro_configuration_id).select { |metric_configuration|
      ALLOWED_METRIC_TYPES.include?(metric_configuration.metric.type)
    }
  end

  def set_metric_configurations
    @metric_configurations = allowed_metric_configurations(@kalibro_configuration.id)
  end

  def metric_type
    'CompoundMetricSnapshot'
  end
end
