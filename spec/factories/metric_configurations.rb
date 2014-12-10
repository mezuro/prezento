FactoryGirl.define do
  factory :metric_configuration, class: MetricConfiguration do
    id 1
    code 'total_abstract_classes'
    metric {FactoryGirl.build(:metric)}
    metric_collector_name "Analizo"
    weight 1
    aggregation_form "AVERAGE"
    reading_group_id 1
    configuration_id 1
  end

  factory :compound_metric_configuration, class: MetricConfiguration do
    id 1
    code 'compound'
    metric { FactoryGirl.build(:compound_metric, script: 'native*2;') }
    weight 1
    aggregation_form "AVERAGE"
    reading_group_id 1
    configuration_id 1
  end

  factory :metric_configuration_with_snapshot, class: MetricConfiguration do
    id 1
    code 'total_modules'
    metric_snapshot {FactoryGirl.build(:metric)}
    metric_collector_name "Analizo"
    weight 1
    aggregation_form "MEDIAN"
    reading_group_id 1
    configuration_id 1
  end

end
