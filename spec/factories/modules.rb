FactoryGirl.define do
  factory :module, class: KalibroClient::Processor::KalibroModule do
    name 'Qt-Calculator'
    granularity 'APPLICATION'
  end
end
