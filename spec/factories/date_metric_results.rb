FactoryGirl.define do
  factory :date_metric_result, class: KalibroClient::Entities::Miscellaneous::DateMetricResult do
    date '2011-10-20T18:26:43.151+00:00'

    # FIXME: A DateMetricResult should be able to create either a TreeMetricResult or a HotspotMetricResult based on
    # the arguments passed to it
    metric_result_attributes { FactoryGirl.attributes_for(:tree_metric_result).except(:aggregated_value) }

    initialize_with { new('date' => date, 'metric_result' => metric_result_attributes) }
  end
end
