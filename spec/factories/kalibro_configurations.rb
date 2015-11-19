FactoryGirl.define do
  factory :kalibro_configuration do
    name "Java"
    description "Code metrics for Java."

    trait :with_id do
      id 1
    end

    trait :with_sequential_id do
      sequence(:id, 1)
    end

    factory :another_kalibro_configuration do
      name "Perl"
      description "Code metrics for Perl."
    end

    factory :public_kalibro_configuration do
      name "Public Kalibro Configuration"
      description "Public Configuration."
    end

    factory :ruby_configuration do
      name "Ruby"
      description "Code metrics for Ruby."
    end
  end
end
