FactoryGirl.define do
  factory :base_tool, class: KalibroGem::Entities::BaseTool do
    name 'Analizo'
    supported_metric {FactoryGirl.build(:loc)}
  end
end
