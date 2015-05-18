# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :kalibro_configuration_attributes, class: KalibroConfigurationAttributes do
    sequence(:id, 1)
    association :user, strategy: :build
    association :kalibro_configuration, :with_id, strategy: :build
    self.public true

    trait :private do
      self.public false
    end
  end
end
