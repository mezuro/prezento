# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reading_group_attributes, class: ReadingGroupAttributes do
    sequence(:id, 1)
    association :user, strategy: :build
    association :reading_group, :with_id, strategy: :build
    self.public true

    trait :private do
      self.public false
    end
  end
end
