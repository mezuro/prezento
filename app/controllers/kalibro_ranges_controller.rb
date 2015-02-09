include OwnershipAuthentication
include ResourceFinder

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
      format.html { redirect_to kalibro_configuration_metric_configuration_path(
          @kalibro_configuration_id, @metric_configuration_id) }
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
        format.html { redirect_to kalibro_configuration_metric_configuration_path(
            @kalibro_configuration_id, @metric_configuration_id), notice: 'Range was successfully edited.' }
        format.json { head :no_content }
      else
        failed_action(format, 'edit')
      end
    end
  end

  private

  def kalibro_range_params
    params[:kalibro_range][:beginning] = params[:kalibro_range][:beginning].to_f.to_s if numeric?(params[:kalibro_range][:beginning]) # this is necessary for the beginning validator
    params[:kalibro_range]
  end

  def create_and_redir(format)
    if @kalibro_range.save
      format.html { redirect_to kalibro_configuration_metric_configuration_path(
          @kalibro_configuration_id, @metric_configuration_id), notice: 'Range was successfully created.' }
    else
      failed_action(format, 'new')
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

  # used on kalibro_range_params
  def numeric?(text)
    Float(text) != nil rescue false
  end

  def set_kalibro_range
    @kalibro_range = find_resource(KalibroRange, params[:id].to_i)
  end
end
