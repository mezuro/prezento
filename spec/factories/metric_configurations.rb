FactoryGirl.define do
  factory :metric_configuration, class: MetricConfiguration do
    id 1
    metric {FactoryGirl.build(:metric, code: 'total_abstract_classes')}
    weight 1
    aggregation_form "AVERAGE"
    reading_group_id 1
    kalibro_configuration_id 1
  end

  factory :compound_metric_configuration, class: MetricConfiguration do
    id 1
    metric { FactoryGirl.build(:compound_metric, script: 'native*2;', code: 'compound') }
    weight 1
    aggregation_form "AVERAGE"
    reading_group_id 1
    kalibro_configuration_id 1
  end

  factory :another_metric_configuration, class: MetricConfiguration do
    id 1
    metric {FactoryGirl.build(:metric, code: 'total_modules')}
    weight 1
    aggregation_form "MEDIAN"
    reading_group_id 1
    kalibro_configuration_id 1
  end

end
