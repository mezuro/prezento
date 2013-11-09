# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    id 1
    name "Diego Martinez"
    email "diego@email.com"
    password "password"
  end
end
