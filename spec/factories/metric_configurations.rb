FactoryGirl.define do
  factory :metric_configuration, class: MetricConfiguration do
    metric {FactoryGirl.build(:metric, code: 'total_abstract_classes')}
    weight 1
    aggregation_form "MEAN"
    reading_group_id 1
    kalibro_configuration_id 1

    trait :with_id do
      id 1
    end

    factory :metric_configuration_with_id, traits: [:with_id]
  end

  factory :compound_metric_configuration, class: MetricConfiguration do
    metric { FactoryGirl.build(:compound_metric, script: 'native*2;', code: 'compound') }
    weight 1
    reading_group_id 1
    kalibro_configuration_id 1

    trait :with_id do
      id 1
    end

    factory :compound_metric_configuration_with_id, traits: [:with_id]
  end

  factory :another_metric_configuration_with_id, class: MetricConfiguration do
    id 1
    metric {FactoryGirl.build(:metric, code: 'total_modules')}
    weight 1
    aggregation_form "MEDIAN"
    reading_group_id 1
    kalibro_configuration_id 1
  end

  factory :hotspot_metric_configuration, class: MetricConfiguration do
    metric { FactoryGirl.build(:hotspot_metric) }
    kalibro_configuration_id 1
  end

  factory :saikuro_metric_configuration, class: MetricConfiguration do
    metric { FactoryGirl.build(:saikuro) }
    weight 1
    aggregation_form "MEAN"
  end
end
