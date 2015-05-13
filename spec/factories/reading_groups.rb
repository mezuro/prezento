FactoryGirl.define do
  factory :reading_group do
    name "Mussum"
    description "Cacildis!"

    trait :with_id do
      sequence(:id, 1)
    end

    factory :another_reading_group do
      name "My Reading Group"
      description "The best one"
    end
  end
end