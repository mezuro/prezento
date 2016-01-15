class MetricConfigurationsController < BaseMetricConfigurationsController
  METRIC_TYPE = 'NativeMetricSnapshot'

  before_action :set_reading_groups!, only: [:new, :edit]

  def new
    super
    # The metric parameter comes from the choose metric form
    set_metric!
  end

  def choose_metric
    @metric_collectors_names = KalibroClient::Entities::Processor::MetricCollectorDetails.all_names
  end

  protected

  def metric_configuration_params
    params.require(:metric_configuration).permit(:weight, :aggregation_form)
  end

  private

  def set_reading_groups!
    @reading_groups = ReadingGroup.public_or_owned_by_user(current_user).map do |reading_group|
      [reading_group.name, reading_group.id]
    end
  end
end
