# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reading_group_attributes, class: ReadingGroupAttributes do
    association :user, strategy: :build
    association :reading_group, :with_id, strategy: :build

    trait :private do
      self.public false
    end
  end
end
