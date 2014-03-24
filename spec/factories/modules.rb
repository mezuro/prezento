FactoryGirl.define do
  factory :module, class: KalibroGatekeeperClient::Entities::Module do
    name 'Qt-Calculator'
    granularity 'APPLICATION'
  end
end