include OwnershipAuthentication

class KalibroRangesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :metric_configuration_owner?, only: [:new, :create, :destroy, :edit, :update]
  before_action :get_url_params, only: [:update, :create, :destroy]
  before_action :set_kalibro_range, only: [:edit, :update, :destroy]

  def new
    @kalibro_range = KalibroRange.new
    before_form
  end

  def create
    @kalibro_range = KalibroRange.new(kalibro_range_params)
    @kalibro_range.metric_configuration_id = params[:metric_configuration_id].to_i
    respond_to do |format|
      create_and_redir(format)
    end
  end

  def destroy
    @kalibro_range.destroy
    respond_to do |format|
      format_metric_configuration_path(format, t('successfully_destroyed', :record => t(@kalibro_range.class)))
      format.json { head :no_content }
    end
  end

  def edit
    before_form
  end

  def update
    respond_to do |format|
      @kalibro_range.metric_configuration_id = @metric_configuration_id
      if @kalibro_range.update(kalibro_range_params)
        format_metric_configuration_path(format, t('successfully_updated', :record => t(@kalibro_range.class)))
        format.json { head :no_content }
      else
        failed_action(format, 'edit')
      end
    end
  end

  private

  def kalibro_range_params
    params[:kalibro_range]
  end

  def create_and_redir(format)
    if @kalibro_range.save
      format_metric_configuration_path(format, t('successfully_created', :record => t(@kalibro_range.class)))
    else
      failed_action(format, 'new')
    end
  end

  def format_metric_configuration_path(format, notice)
    @metric_configuration = MetricConfiguration.find(@kalibro_range.metric_configuration_id)

    if(@metric_configuration.metric.is_a? KalibroClient::Entities::Miscellaneous::CompoundMetric)
      format.html { redirect_to kalibro_configuration_compound_metric_configuration_path(
        @kalibro_configuration_id, @metric_configuration_id), notice: notice }
    else
      format.html { redirect_to kalibro_configuration_metric_configuration_path(
        @kalibro_configuration_id, @metric_configuration_id), notice: notice }
    end
  end

  def failed_action(format, destiny_action)
    before_form
    format.html { render action: destiny_action }
    format.json { render json: @kalibro_range.errors, status: :unprocessable_entity }
  end

  def before_form
    get_url_params
    @reading_group_id = MetricConfiguration.find(@metric_configuration_id).reading_group_id
    @readings = Reading.readings_of(@reading_group_id)
  end

  def get_url_params
    @kalibro_configuration_id = params[:kalibro_configuration_id].to_i
    @metric_configuration_id = params[:metric_configuration_id].to_i
  end

  def set_kalibro_range
    @kalibro_range = KalibroRange.find(params[:id].to_i)
  end
end
