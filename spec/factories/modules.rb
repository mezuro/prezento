FactoryGirl.define do
  factory :module, class: KalibroGem::Entities::Module do
    name 'Qt-Calculator'
    granularity 'APPLICATION'
  end
end