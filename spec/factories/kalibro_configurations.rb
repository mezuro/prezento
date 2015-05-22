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
  end
end
