  FactoryGirl.define do
  factory :mezuro_configuration, class: MezuroConfiguration do
    id 1
    name "Java"
    description "Code metrics for Java."
  end

  factory :another_mezuro_configuration, class: MezuroConfiguration do
    id 12
    name "Perl"
    description "Code metrics for Perl."
  end
end
