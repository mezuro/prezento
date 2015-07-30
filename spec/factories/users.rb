# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    id 1
    name "Diego Martinez"
    email "diego@email.com"
    password "password"

    factory :another_user do
      id 2
      name "Heitor Reis"
      email "hr@email.com"
      password "password"
    end
  end
end
