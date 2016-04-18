FactoryGirl.define do
  factory :repository_attributes do
    self.public true
    association :user, strategy: :build
    association :repository, strategy: :build

    trait :private do
      self.public false
    end
  end
end
