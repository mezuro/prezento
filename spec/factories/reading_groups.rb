FactoryGirl.define do
  factory :reading_group do
    name "Mussum"
    description "Cacildis!"

    trait :with_id do
      id 1
    end

    factory :reading_group_with_id, traits: [:with_id]
  end

  factory :another_reading_group, class: ReadingGroup do
    name "My Reading Group"
    description "The best one"

    trait :with_id do
      id 2
    end

    factory :another_reading_group_with_id, traits: [:with_id]
  end
end
