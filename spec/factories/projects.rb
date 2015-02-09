# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "QT Calculator"
    description "A simple calculator for us."

    trait :with_id do
      id 1
    end

    factory :project_with_id, traits: [:with_id]
  end

  factory :another_project, class: Project do
    id 2
    name "Kalibro"
    description "Code Metrics"
  end
end
