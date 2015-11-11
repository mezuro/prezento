FactoryGirl.define do
  factory :project_attributes, :class => 'ProjectAttributes' do
    image_url ''
    self.public true
    association :project, :with_id, strategy: :build
    association :user, strategy: :build

    trait :with_image do
      image_url '#'
    end

    trait :private do
      self.public false
    end

    trait :bare do
      project_id nil
      user_id nil
    end
  end
end
