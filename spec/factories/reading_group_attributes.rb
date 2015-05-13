# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reading_group_attributes, class: ReadingGroupAttributes do
    association :user, strategy: :build
    association :reading_group, :with_id, strategy: :build
    self.public false

    trait :public do
      self.public true
    end
  end
end
