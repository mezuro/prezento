module MetricConfigurationsConcern
  extend ActiveSupport::Concern

  def set_metric_configuration
    @metric_configuration = find_resource(MetricConfiguration, params[:id].to_i)
  end
end
