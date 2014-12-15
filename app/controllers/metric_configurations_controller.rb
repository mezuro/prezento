class MetricConfigurationsController < BaseMetricConfigurationsController
  def choose_metric
    @kalibro_configuration = KalibroConfiguration.find(params[:kalibro_configuration_id].to_i)
    @metric_configuration_id = params[:metric_configuration_id].to_i
    @metric_collectors_names = KalibroClient::Processor::MetricCollector.all_names
  end

  def new
    super
    metric_configuration.metric_collector_name = params[:metric_collector_name]
    metric_configuration.metric = KalibroClient::Processor::MetricCollector.find(params[:metric_collector_name]).metric params[:metric_code]
  end

  def create
    super
    @metric_configuration.metric = KalibroClient::Processor::MetricCollector.find(params[:metric_collector_name]).metric params[:metric_name]
    @metric_configuration.metric_collector_name = params[:metric_collector_name]
    @metric_configuration.code = @metric_configuration.metric.code
    respond_to do |format|
      create_and_redir(format)
    end
    Rails.cache.delete("#{params[:kalibro_configuration_id]}_metric_configurations")
  end

  def edit
    #FIXME: set the configuration id just once!
    @kalibro_configuration_id = params[:kalibro_configuration_id]
    @metric_configuration.configuration_id = @kalibro_configuration_id
  end

  def update
    respond_to do |format|
      @metric_configuration.configuration_id = params[:kalibro_configuration_id]
      if @metric_configuration.update(metric_configuration_params)
        format.html { redirect_to(kalibro_configuration_path(@metric_configuration.configuration_id), notice: 'Metric Configuration was successfully updated.') }
        format.json { head :no_content }
        Rails.cache.delete("#{@metric_configuration.configuration_id}_metric_configurations")
      else
        failed_action(format, 'edit')
      end
    end
  end

  def destroy
    @metric_configuration.destroy
    respond_to do |format|
      format.html { redirect_to kalibro_configuration_path(params[:kalibro_configuration_id]) }
      format.json { head :no_content }
    end
    Rails.cache.delete("#{params[:kalibro_configuration_id]}_metric_configurations")
  end

  protected

  def metric_configuration
    @metric_configuration
  end

  def update_metric_configuration (new_metric_configuration)
    @metric_configuration = new_metric_configuration
  end

  private

  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    @kalibro_configuration_id = params[:kalibro_configuration_id]

    format.html { render action: destiny_action }
    format.json { render json: @metric_configuration.errors, status: :unprocessable_entity }
  end

  #Code extracted from create action
  def create_and_redir(format)
    if @metric_configuration.save
      format.html { redirect_to kalibro_configuration_path(@metric_configuration.configuration_id), notice: 'Metric Configuration was successfully created.' }
    else
      failed_action(format, 'new')
    end
  end
end
