class HotspotMetricConfigurationsController < BaseMetricConfigurationsController
  def create
    super
    @metric_configuration.metric = KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name(params[:metric_collector_name]).find_metric_by_code params[:metric_code]
    respond_to do |format|
      if @metric_configuration.save
        format.html do
          redirect_to kalibro_configuration_path(@metric_configuration.kalibro_configuration_id),
            notice: t('successfully_created', record: t(@metric_configuration.class))
        end
      else
        failed_action(format)
      end
    end
    clear_caches
  end

  protected

  def update_metric_configuration(new_metric_configuration)
    @kalibro_configuration_id = params[:kalibro_configuration_id]
    @metric_configuration = new_metric_configuration
  end

  def metric_configuration_params
    { kalibro_configuration_id: params[:kalibro_configuration_id] }
  end

  private

  def failed_action(format)
    @kalibro_configuration_id = params[:kalibro_configuration_id]
    format.html { redirect_to kalibro_configuration_choose_metric_path }
    format.json { render json: @metric_configuration.kalibro_errors, status: :unprocessable_entity }
  end

  def clear_caches
    Rails.cache.delete("#{params[:kalibro_configuration_id]}_tree_metric_configurations")
    Rails.cache.delete("#{params[:kalibro_configuration_id]}_hotspot_metric_configurations")
  end
end
