class CompoundMetricConfigurationsController < BaseMetricConfigurationsController
  before_action :set_metric_configurations, only: [:new, :edit]

  def create
    super
    @compound_metric_configuration.metric.type = "CompoundMetricSnapshot"
    respond_to do |format|
      create_and_redir(format)
    end
    Rails.cache.delete("#{params[:kalibro_configuration_id].to_i}_metric_configurations")
  end

  def show
    update_metric_configuration(@metric_configuration)
    super
  end

  def edit
    @compound_metric_configuration = @metric_configuration
    @kalibro_configuration_id = params[:kalibro_configuration_id].to_i
    @compound_metric_configuration.kalibro_configuration_id = @kalibro_configuration_id
  end

  def update
    respond_to do |format|
      edit
      if @compound_metric_configuration.update(metric_configuration_params)
        format.html { redirect_to kalibro_configuration_path(@compound_metric_configuration.kalibro_configuration_id), notice: t('successfully_updated', :record => t('compound') + " " + @compound_metric_configuration.class.model_name.human) }
        format.json { head :no_content }
      else
        failed_action(format, 'edit')
      end
      Rails.cache.delete("#{@compound_metric_configuration.kalibro_configuration_id}_metric_configurations")
    end
  end

  protected

  def metric_configuration
    @compound_metric_configuration
  end

  def update_metric_configuration (new_metric_configuration)
    @kalibro_configuration_id = params[:kalibro_configuration_id]
    @compound_metric_configuration = new_metric_configuration
  end

  private

  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    @kalibro_configuration_id = params[:kalibro_configuration_id]

    set_metric_configurations
    format.html { render action: destiny_action }
    format.json { render json: @compound_metric_configuration.kalibro_errors, status: :unprocessable_entity }
  end

  #Code extracted from create action
  def create_and_redir(format)
    if @compound_metric_configuration.save
      format.html { redirect_to kalibro_configuration_path(@compound_metric_configuration.kalibro_configuration_id), notice: t('successfully_created', :record => t('compound') + " " + @compound_metric_configuration.class.model_name.human) }
    else
      failed_action(format, 'new')
    end
  end

  def set_metric_configurations
    @metric_configurations = MetricConfiguration.metric_configurations_of(params[:kalibro_configuration_id].to_i)
  end

end
