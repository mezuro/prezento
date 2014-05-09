# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    id 1
    name "Diego Martinez"
    email "diego@email.com"
    password "password"
  end

  factory :another_user do
    id 2
    name "Pedro Scocco"
    email "pedro@email.com"
    password "password2"
  end
end
