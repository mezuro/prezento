class MetricConfigurationsController < BaseMetricConfigurationsController
  def choose_metric
    @mezuro_configuration_id = params[:mezuro_configuration_id].to_i
    @metric_configuration_id = params[:metric_configuration_id].to_i
    @base_tools = KalibroGatekeeperClient::Entities::BaseTool.all
    @exist_metric = params[:exist_metric]
  end

  def new
    super
    metric_configuration.base_tool_name = params[:base_tool_name]
    metric_configuration.metric = KalibroGatekeeperClient::Entities::BaseTool.find_by_name(params[:base_tool_name]).metric params[:metric_name]
  end

  def create
    super
    @metric_configuration.metric = KalibroGatekeeperClient::Entities::BaseTool.find_by_name(params[:base_tool_name]).metric params[:metric_name]
    @metric_configuration.base_tool_name = params[:base_tool_name]
    respond_to do |format|
      create_and_redir(format)
    end
  end

  def edit
    #FIXME: set the configuration id just once!
    @mezuro_configuration_id = params[:mezuro_configuration_id]
    @metric_configuration.configuration_id = @mezuro_configuration_id
  end

  def update
    respond_to do |format|
      @metric_configuration.configuration_id = params[:mezuro_configuration_id]
      if @metric_configuration.update(metric_configuration_params)
        format.html { redirect_to(mezuro_configuration_path(@metric_configuration.configuration_id), notice: 'Metric Configuration was successfully updated.') }
        format.json { head :no_content }
      else
        failed_action(format, 'edit')
      end
    end
  end

  def destroy
    @metric_configuration.destroy
    respond_to do |format|
      format.html { redirect_to mezuro_configuration_path(params[:mezuro_configuration_id]) }
      format.json { head :no_content }
    end
  end

  protected

  def metric_configuration
    @metric_configuration
  end

  def update_metric_configuration (new_metric_configuration)
    @metric_configuration = new_metric_configuration
  end

  private

  # Duplicated code on create and update actions extracted here
  def failed_action(format, destiny_action)
    @mezuro_configuration_id = params[:mezuro_configuration_id]

    format.html { render action: destiny_action }
    format.json { render json: @metric_configuration.errors, status: :unprocessable_entity }
  end

  #Code extracted from create action
  def create_and_redir(format)
    if @metric_configuration.save
      format.html { redirect_to mezuro_configuration_path(@metric_configuration.configuration_id), notice: 'Metric Configuration was successfully created.' }
    else
      failed_action(format, 'new')
    end
  end
end
