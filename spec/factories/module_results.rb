FactoryGirl.define do
  factory :module_result, class: ModuleResult do
    id 42
    kalibro_module { FactoryGirl.build(:kalibro_module) }
    grade 10.0
    parent_id 21
    height 6
  end

  factory :root_module_result, class: ModuleResult do
    id 21
    kalibro_module { FactoryGirl.build(:kalibro_module) }
    grade 6.0
    parent_id nil
    height 1
  end
end
