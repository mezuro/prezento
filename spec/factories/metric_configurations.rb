FactoryGirl.define do
  factory :metric_configuration, class: MetricConfiguration do
    id 1
    code 'native'
    metric {FactoryGirl.build(:metric)}
    base_tool_name "Analizo"
    weight 1
    aggregation_form "AVERAGE"
    reading_group_id 1
    configuration_id 1
  end

  factory :compound_metric_configuration, class: MetricConfiguration do
    id 1
    code 'compound'
    metric {FactoryGirl.build(:compound_metric, {script: 'native*2;'})}
    weight 1
    aggregation_form "AVERAGE"
    reading_group_id 1
    configuration_id 1
  end
end