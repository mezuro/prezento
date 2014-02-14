module MetricConfigurationsConcern
  extend ActiveSupport::Concern

  def set_metric_configuration
    @metric_configuration = MetricConfiguration.find(params[:id].to_i)
  end
end
