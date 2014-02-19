include OwnershipAuthentication

class MezuroRangesController < ApplicationController

  def new
    @mezuro_range = MezuroRange.new
    @mezuro_range.metric_configuration_id = params[:metric_configuration_id].to_i
    @mezuro_range.mezuro_configuration_id = params[:mezuro_configuration_id].to_i
    @reading_group_id = MetricConfiguration.find(@mezuro_range.metric_configuration_id).reading_group_id
    @readings = Reading.readings_of(@reading_group_id)
  end

  def show
  end

  def create
  end

  def destroy
  end

  def update
  end

  def index
  end

  def edit
  end

end
