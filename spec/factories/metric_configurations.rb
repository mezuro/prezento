FactoryGirl.define do
  factory :metric_configuration, class: KalibroEntities::Entities::MetricConfiguration do
    id 1
    code 'code'
    metric {FactoryGirl.build(:metric)}
    base_tool_name "Analizo"
    weight 1
    aggregation_form "AVERAGE"
    reading_group_id 1
    configuration_id 1
  end
end