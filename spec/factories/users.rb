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
    
    factory :mezuro_user do
      name "Mezuro Default user"
      email "mezuro@librelist.com"
      password Devise.friendly_token.first(10)
    end
  end
end
