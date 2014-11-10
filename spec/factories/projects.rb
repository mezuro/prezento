# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    id 1
    name "QT Calculator"
    description "A simple calculator for us."
    image_url { FactoryGirl.build(:project_image) }
  end

  factory :another_project, class: Project do
    id 2
    name "Kalibro"
    description "Code Metrics"
  end
end
