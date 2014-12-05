FactoryGirl.define do
  factory :metric_collector, class: KalibroClient::Processor::MetricCollector do
    name 'Analizo'
    supported_metrics { { "total_abstract_classes" => FactoryGirl.build(:metric), "loc" => FactoryGirl.build(:loc)} }
  end
end
