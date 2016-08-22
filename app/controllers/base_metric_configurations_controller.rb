class BaseMetricConfigurationsController < ApplicationController
  include OwnershipAuthentication
  include MetricConfigurationsConcern

  before_action :authenticate_user!, except: [:show]
  before_action :metric_configuration_owner?, only: [:edit, :update, :destroy]
  before_action :kalibro_configuration_owner?, only: [:new, :create, :choose_metric]
  before_action :set_kalibro_configuration!
  before_action :find_metric_configuration!, only: [:show, :edit, :update, :destroy]
  before_action :new_metric_configuration!, only: [:create]
  before_action :set_metric!, only: [:create, :update]
  before_action :set_reading_group!, only: [:show, :edit, :create, :update]

  def show
    @kalibro_ranges = @metric_configuration.kalibro_ranges
  end

  def new
    @metric_configuration = MetricConfiguration.new
  end

  def edit
  end

  def create
    respond_to { |format| save_and_redir(format) }
  end

  def update
    respond_to do |format|
      save_and_redir(format) do |metric_configuration|
        metric_configuration.update(metric_configuration_params)
      end
    end
  end

  def destroy
    @metric_configuration.destroy
    clear_caches

    respond_to do |format|
      format.html { redirect_to kalibro_configuration_path(@kalibro_configuration.id) }
      format.json { head :no_content }
    end
  end

  protected

  def save_and_redir(format)
    new_record = @metric_configuration.id.nil?
    result = block_given? ? (yield @metric_configuration) : @metric_configuration.save

    if result
      clear_caches

      format.html do
        redirect_to kalibro_configuration_path(@kalibro_configuration.id),
          notice: t(new_record ? 'successfully_created' : 'successfully_updated',
                    record: t(@metric_configuration.class))
      end
      format.json { render json: @metric_configuration, status: new_record ? :created : :ok }
    else
      failed_action(format)
    end
  end

  def failed_action(format, error = nil)
    errors = @metric_configuration.likeno_errors
    errors << error unless error.nil?

    flash[:notice] = errors.join(', ')

    format.json { render json: { errors: errors }, status: :unprocessable_entity }
    render_failure_html(format)
  end

  def render_failure_html(format)
    if action_name == 'create'
      format.html { render 'new' }
    elsif action_name == 'update'
      format.html { render 'edit' }
    else
      format.html { redirect_to kalibro_configuration_path(@kalibro_configuration.id) }
    end
  end

  def clear_caches
    Rails.cache.delete("#{@kalibro_configuration.id}_tree_metric_configurations")
    Rails.cache.delete("#{@kalibro_configuration.id}_hotspot_metric_configurations")
  end

  # Notice: If you add some logic to this method, remove the :nocov: below
  # :nocov:
  def metric_configuration_params
    raise NotImplementedError
  end
  # :nocov:

  def set_kalibro_configuration!
    @kalibro_configuration = KalibroConfiguration.find params[:kalibro_configuration_id].to_i
  end

  def new_metric_configuration!
    @metric_configuration = MetricConfiguration.new metric_configuration_params
    @metric_configuration.kalibro_configuration_id = @kalibro_configuration.id
  end

  def find_metric_configuration!
    @metric_configuration = MetricConfiguration.find params[:id].to_i

    # Make sure the metric configuration is really from the kalibro configuration we're being told it is
    if @metric_configuration.kalibro_configuration_id != @kalibro_configuration.id
      raise Likeno::Errors::RecordNotFound
    end
  end

  def set_metric!
    collector = KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name(params[:metric_collector_name])
    # FIXME: Some view pass metric code as a parameter instead of metric name
    if params.key?(:metric_code)
      metric = collector.find_metric_by_code(params[:metric_code])
    else
      metric = collector.find_metric_by_name(params[:metric_name])
    end

    if !metric.nil? && metric.type == self.metric_type
      @metric_configuration.metric = metric
      return
    end

    respond_to do |format|
      failed_action(format, t('invalid_metric_or_collector'))
    end
  end

  def set_reading_group!
    begin
      @reading_group = ReadingGroup.find(@metric_configuration.reading_group_id)
    rescue Likeno::Errors::RecordNotFound
      respond_to do |format|
        failed_action(format, t('invalid_model', model: ReadingGroup.model_name.human))
      end
    end
  end

  # Notice: If you add some logic to this method, remove the :nocov: below
  # :nocov:
  def metric_type
    raise NotImplementedError
  end
  # :nocov:
end
