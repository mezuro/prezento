# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project_image do
    project_id 1
    url "Example"
  end

  factory :project_no_image, class: ProjectImage do
    url nil
  end
end
