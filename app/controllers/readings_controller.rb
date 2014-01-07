include OwnershipAuthentication

class ReadingsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  # before_action :reading_group_owner?, except: [:show]

  def new
    @reading_group_id = params[:reading_group_id]
    @reading = Reading.new
  end

  def create
    @reading = Reading.new(reading_params)
    @reading.group_id = params[:reading_group_id]
    respond_to do |format|
      create_and_redir(format)
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def reading_params
    params[:reading]
  end

  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    @reading_group_id = params[:reading_group_id]

    format.html { render action: destiny_action }
    format.json { render json: @reading.errors, status: :unprocessable_entity }
  end

  # Code extracted from create action
  def create_and_redir(format)
    if @reading.save
      format.html { redirect_to reading_group_path(@reading.group_id), notice: 'Reading was successfully created.' }
    else
      failed_action(format, 'new')
    end
  end

end
