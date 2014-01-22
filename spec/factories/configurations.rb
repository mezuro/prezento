FactoryGirl.define do
  factory :configuration, class: Configuration do
    id 1
    name "Java"
    description "Code metrics for Java."
  end

  factory :another_configuration, class: Configuration do
    id 12
    name "Perl"
    description "Code metrics for Perl."
  end
end