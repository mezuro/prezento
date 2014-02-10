include OwnershipAuthentication

class CompoundMetricConfigurationsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :mezuro_configuration_owner?, only: [:new]

  # GET mezuro_configurations/1/compound_metric_configurations/new
  def new
    @compound_metric_configuration = MetricConfiguration.new
    @compound_metric_configuration.configuration_id = params[:mezuro_configuration_id].to_i
  end

end
