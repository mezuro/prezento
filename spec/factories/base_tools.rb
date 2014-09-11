FactoryGirl.define do
  factory :base_tool, class: KalibroGatekeeperClient::Entities::MetricCollector do
    name 'Analizo'
    supported_metrics { { "total_abstract_classes" => FactoryGirl.build(:metric).to_hash, "loc" => FactoryGirl.build(:loc).to_hash } }
  end
end
