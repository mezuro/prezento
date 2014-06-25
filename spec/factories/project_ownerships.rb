# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_ownership do
    user_id 1
    project_id 1
    image_url "http://example.com/image.png"
  end
end
