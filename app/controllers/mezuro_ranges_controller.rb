include OwnershipAuthentication

class MezuroRangesController < ApplicationController

  def new
    @mezuro_range = MezuroRange.new
    @mezuro_range.metric_configuration_id = params[:metric_configuration_id].to_i
    @mezuro_range.mezuro_configuration_id = params[:mezuro_configuration_id].to_i
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