FactoryGirl.define do
  factory :metric_collector, class: KalibroClient::Processor::MetricCollector do
    name 'Analizo'
    description 'A metric collector'
    supported_metrics { { "total_abstract_classes" => FactoryGirl.build(:metric), "loc" => FactoryGirl.build(:loc)} }

    initialize_with { new({"name" => name, "description" => description, "supported_metrics" => supported_metrics}) }
  end
end
