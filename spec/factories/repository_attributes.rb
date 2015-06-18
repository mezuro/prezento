FactoryGirl.define do
  factory :repository_attributes do
    association :user, strategy: :build
    association :repository, strategy: :build
  end
end
