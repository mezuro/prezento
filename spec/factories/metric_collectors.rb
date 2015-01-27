FactoryGirl.define do
  factory :metric_collector, class: KalibroClient::Entities::Processor::MetricCollectorDetails do
    name 'Analizo'
    description 'A metric collector'
    supported_metrics { { "total_abstract_classes" => FactoryGirl.build(:metric).to_hash, "loc" => FactoryGirl.build(:loc).to_hash} }

    initialize_with { new({"name" => name, "description" => description, "supported_metrics" => supported_metrics}) }
  end
end
