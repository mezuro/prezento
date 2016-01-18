class HotspotMetricConfigurationsController < BaseMetricConfigurationsController
  METRIC_TYPE = 'HotspotMetricSnapshot'

  skip_before_action :set_reading_group!

  def metric_configuration_params
    # Hotspot metric configurations don't accept any parameters on creation
    # But we must make that explicit as the method isn't implemented in the parent class
    params.permit
  end

  def render_failure_html(format)
    format.html { redirect_to kalibro_configuration_path(@kalibro_configuration.id) }
  end
end
