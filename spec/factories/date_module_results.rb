FactoryGirl.define do
  factory :date_module_result, class: KalibroClient::Entities::Miscellaneous::DateModuleResult do
    date "2011-10-20T18:26:43.151+00:00"
    module_result {FactoryGirl.build(:module_result)}

    initialize_with { new({:date => date, :module_result => module_result}) }
  end
end
