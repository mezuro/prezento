FactoryGirl.define do
  factory :project_attributes, :class => 'ProjectAttributes' do
    project_id 1
    image_url ''
    user_id 1
    hidden false

    trait :with_image do
      image_url '#'
    end
  end
end
