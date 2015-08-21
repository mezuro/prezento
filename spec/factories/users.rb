# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name "Diego Martinez"
    email "diego@email.com"
    password "password"

    factory :another_user do
      name "Heitor Reis"
      email "hr@email.com"
      password "password"
    end
    
    trait :with_id do
      sequence(:id, 1)
    end
  end
end
