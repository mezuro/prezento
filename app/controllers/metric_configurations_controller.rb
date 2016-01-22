class MetricConfigurationsController < BaseMetricConfigurationsController
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
    params.require(:metric_configuration).permit(:reading_group_id, :weight, :aggregation_form)
  end

  def metric_type
    'NativeMetricSnapshot'
  end

  private

  def set_reading_groups!
    @reading_groups = ReadingGroup.public_or_owned_by_user(current_user).map do |reading_group|
      [reading_group.name, reading_group.id]
    end
  end
end
