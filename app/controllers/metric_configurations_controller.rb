class MetricConfigurationsController < BaseMetricConfigurationsController
  def choose_metric
    @kalibro_configuration = KalibroConfiguration.find(params[:kalibro_configuration_id].to_i)
    @metric_configuration_id = params[:metric_configuration_id].to_i
    @metric_collectors_names = KalibroClient::Entities::Processor::MetricCollectorDetails.all_names
  end

  def new
    super
    # find_by_name throws an exception instead of returning nil, unlike ActiveRecord's API
    metric_configuration.metric = KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name(params[:metric_collector_name]).find_metric_by_code params[:metric_code]
    @reading_groups = ReadingGroup.public_or_owned_by_user(current_user).map { |reading_group|
      [reading_group.name, reading_group.id]
    }
  end

  def create
    super
    @metric_configuration.metric = KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name(params[:metric_collector_name]).find_metric_by_name params[:metric_name]
    respond_to do |format|
      create_and_redir(format)
    end
    Rails.cache.delete("#{params[:kalibro_configuration_id]}_metric_configurations")
  end

  def edit
    #FIXME: set the configuration id just once!
    @kalibro_configuration_id = params[:kalibro_configuration_id]
    @metric_configuration.kalibro_configuration_id = @kalibro_configuration_id
    @reading_groups = ReadingGroup.public_or_owned_by_user(current_user).map { |reading_group|
      [reading_group.name, reading_group.id]
    }
  end

  def update
    respond_to do |format|
      @metric_configuration.kalibro_configuration_id = params[:kalibro_configuration_id]
      if @metric_configuration.update(metric_configuration_params)
        format.html { redirect_to(kalibro_configuration_path(@metric_configuration.kalibro_configuration_id), notice: t('successfully_updated', :record => t(metric_configuration.class))) }
        format.json { head :no_content }
        Rails.cache.delete("#{@metric_configuration.kalibro_configuration_id}_metric_configurations")
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
    @kalibro_configuration_id = params[:kalibro_configuration_id]
    @metric_configuration = new_metric_configuration
  end

  private

  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    @kalibro_configuration_id = params[:kalibro_configuration_id]

    format.html { render action: destiny_action }
    format.json { render json: @metric_configuration.kalibro_errors, status: :unprocessable_entity }
  end

  #Code extracted from create action
  def create_and_redir(format)
    if @metric_configuration.save
      format.html { redirect_to kalibro_configuration_path(@metric_configuration.kalibro_configuration_id), notice: t('successfully_created', :record => t(metric_configuration.class)) }
    else
      failed_action(format, 'new')
    end
  end
end
