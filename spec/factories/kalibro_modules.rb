FactoryGirl.define do
  factory :kalibro_module, class: KalibroClient::Entities::Processor::KalibroModule do
    name 'Qt-Calculator'
    granlrty 'APPLICATION'
  end
end
