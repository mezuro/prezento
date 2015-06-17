FactoryGirl.define do
  factory :repository_attributes do
    repository_id 1
    association :user, strategy: :build
  end
end
