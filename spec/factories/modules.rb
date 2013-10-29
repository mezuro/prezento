FactoryGirl.define do
  factory :module, class: KalibroEntities::Entities::Module do
    name 'Qt-Calculator'
    granularity 'APPLICATION'
  end
end