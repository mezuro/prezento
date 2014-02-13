module MetricConfigurationsConcern
  extend ActiveSupport::Concern

  def set_metric_configuration
    @metric_configuration = MetricConfiguration.find(params[:id].to_i)
  end

  def update_metric_configuration
    respond_to do |format|
      @metric_configuration.configuration_id = params[:mezuro_configuration_id]
      if @metric_configuration.update(metric_configuration_params)
        format.html { redirect_to(mezuro_configuration_path(@metric_configuration.configuration_id), notice: 'Metric Configuration was successfully updated.') }
        format.json { head :no_content }
      else
        failed_action(format, 'edit')
      end
    end
  end
end
