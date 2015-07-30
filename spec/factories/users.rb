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
    
    factory :mezuro_user do
      name "Mezuro Default user"
      email "mezuro@librelist.com"
    end

    trait :with_id do
      sequence(:id, 1)
    end
  end
end
