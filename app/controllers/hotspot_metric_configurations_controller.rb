class HotspotMetricConfigurationsController < BaseMetricConfigurationsController
  METRIC_TYPE = 'HotspotMetricSnapshot'

  def metric_configuration_params
    # Hotspot metric configurations don't accept any parameters on creation
    # But we must make that explicit as the method isn't implemented in the parent class
    params.permit
  end

  # FIXME: This action should render with an error message on rendering the html
  def failed_action(format, _)
    format.html { redirect_to kalibro_configurations_path(@kalibro_configuration.id) }
    format.json { render json: @metric_configuration.kalibro_errors, status: :unprocessable_entity }
  end
end
