include OwnershipAuthentication

class MezuroRangesController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :metric_configuration_owner?, only: [:new, :create, :destroy, :edit, :update]
  before_action :get_url_params, only: [:update, :create, :destroy]
  before_action :set_mezuro_range, only: [:edit, :update]

  def new
    @mezuro_range = MezuroRange.new
    before_form
  end

  def create
    @mezuro_range = MezuroRange.new(mezuro_range_params)
    @mezuro_range.metric_configuration_id = params[:metric_configuration_id].to_i
    respond_to do |format|
      create_and_redir(format)
    end
  end

  def destroy
    @mezuro_range = MezuroRange.find(params[:id].to_i)
    @mezuro_range.destroy
    respond_to do |format|
      format.html { redirect_to mezuro_configuration_metric_configuration_path(
          @mezuro_configuration_id, @metric_configuration_id) }
      format.json { head :no_content }
    end
  end

  def edit
    before_form
  end

  def update
    respond_to do |format|
      @mezuro_range.metric_configuration_id = @metric_configuration_id
      if @mezuro_range.update(mezuro_range_params)
        format.html { redirect_to mezuro_configuration_metric_configuration_path(
            @mezuro_configuration_id, @metric_configuration_id), notice: 'The range was successfully edited.' }
        format.json { head :no_content }
      else
        failed_action(format, 'edit')
      end    
    end
  end

  private

  def mezuro_range_params
    params[:mezuro_range][:beginning] = params[:mezuro_range][:beginning].to_f.to_s if numeric?(params[:mezuro_range][:beginning]) # this is necessary for the beginning validator
    params[:mezuro_range]
  end

  def create_and_redir(format)
    if @mezuro_range.save
      format.html { redirect_to mezuro_configuration_metric_configuration_path(
          @mezuro_configuration_id, @metric_configuration_id), notice: 'The range was successfully created.' }
    else
      failed_action(format, 'new')
    end
  end

  def failed_action(format, destiny_action)
    before_form
    format.html { render action: destiny_action }
    format.json { render json: @mezuro_range.errors, status: :unprocessable_entity }
  end

  def before_form
    get_url_params
    @reading_group_id = MetricConfiguration.find(@metric_configuration_id).reading_group_id
    @readings = Reading.readings_of(@reading_group_id)
  end

  def get_url_params
    @mezuro_configuration_id = params[:mezuro_configuration_id].to_i
    @metric_configuration_id = params[:metric_configuration_id].to_i
  end

  # used on mezuro_range_params
  def numeric?(text)
    Float(text) != nil rescue false
  end

  def set_mezuro_range
    @mezuro_range = MezuroRange.find(params[:id].to_i)
  end
end
