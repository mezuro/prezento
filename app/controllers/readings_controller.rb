include OwnershipAuthentication

class ReadingsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :reading_owner?, except: [:new, :create]
  before_action :reading_group_owner?, only: [:new, :create]
  before_action :set_reading, only: [:edit, :update, :destroy]

  def new
    @reading = Reading.new
    @reading_group_id = params[:reading_group_id]
  end

  def create
    @reading = Reading.new(reading_params)
    respond_to do |format|
      create_and_redir(format)
    end
  end

  # GET /readings/1/edit
  def edit
  end

  # PUT /reading_groups/1/readings/1
  # PUT /reading_groups/1/readings/1.json
  def update
    respond_to do |format|
      if @reading.update(reading_params)
        format.html { redirect_to(reading_group_path(@reading.reading_group_id), notice: t('successfully_updated', :record => t(@reading.class))) }
        format.json { head :no_content }
      else
        failed_action(format, 'edit')
      end
    end
  end

  # DELETE /reading_groups/1/readings/1
  # DELETE /reading_groups/1/readings/1
  def destroy
    @reading.destroy
    respond_to do |format|
      format.html { redirect_to reading_group_path(params[:reading_group_id].to_i) }
      format.json { head :no_content }
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def reading_params
    params[:reading][:label].strip!
    params[:reading]
  end

  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    format.html { render action: destiny_action }
    format.json { render json: @reading.likeno_errors, status: :unprocessable_entity }
  end

  # Code extracted from create action
  def create_and_redir(format)
    if @reading.save
      format.html { redirect_to reading_group_path(@reading.reading_group_id), notice: t('successfully_created', :record => t(@reading.class)) }
    else
      @reading_group_id = params[:reading_group_id]
      failed_action(format, 'new')
    end
  end

  def set_reading
    @reading = Reading.find(params[:id].to_i)
  end
end
