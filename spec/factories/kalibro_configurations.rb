  FactoryGirl.define do
  factory :kalibro_configuration, class: KalibroConfiguration do
    name "Java"
    description "Code metrics for Java."

    trait :with_id do
      id 1
    end

    factory :kalibro_configuration_with_id, traits: [:with_id]
  end

  factory :another_kalibro_configuration, class: KalibroConfiguration do
    name "Perl"
    description "Code metrics for Perl."

    trait :with_id do
      id 12
    end

    factory :another_kalibro_configuration_with_id, traits: [:with_id]
  end
end
