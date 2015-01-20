FactoryGirl.define do
  factory :module, class: KalibroClient::Entities::Processor::KalibroModule do
    name 'Qt-Calculator'
    granularity 'APPLICATION'
  end
end
