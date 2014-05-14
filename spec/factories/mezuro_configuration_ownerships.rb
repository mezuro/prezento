# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :mezuro_configuration_ownership do
    user_id 1
    mezuro_configuration_id 1
    fork_count 0
  end

  factory :another_mezuro_configuration_ownership do
    user_id 2
    mezuro_configuration_id 12
    fork_count 0
    parent_id 1
  end
end
