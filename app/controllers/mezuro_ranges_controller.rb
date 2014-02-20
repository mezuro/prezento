include OwnershipAuthentication

class MezuroRangesController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]
  before_action :metric_configuration_owner?, except: [:index]

  def new
    @mezuro_range = MezuroRange.new
    before_form
  end

  def create
    @mezuro_range = MezuroRange.new(mezuro_range_params)
    @mezuro_configuration_id = params[:mezuro_configuration_id].to_i
    @metric_configuration_id = params[:metric_configuration_id].to_i
    @mezuro_range.metric_configuration_id = params[:metric_configuration_id].to_i
    respond_to do |format|
      create_and_redir(format)
    end
  end

  def destroy
  end

  def update
  end

  def index
  end

  def edit
  end

  private

  def mezuro_range_params
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
    @mezuro_configuration_id = params[:mezuro_configuration_id].to_i
    @metric_configuration_id = params[:metric_configuration_id].to_i
    @reading_group_id = MetricConfiguration.find(@metric_configuration_id).reading_group_id
    @readings = Reading.readings_of(@reading_group_id)
  end

end
