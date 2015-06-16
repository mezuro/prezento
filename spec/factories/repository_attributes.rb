FactoryGirl.define do
  factory :repository_attribute do
    repository_id 1
    association :user, strategy: :build
  end
end
