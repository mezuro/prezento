  FactoryGirl.define do
  factory :kalibro_configuration, class: KalibroConfiguration do
    id 1
    name "Java"
    description "Code metrics for Java."
  end

  factory :another_kalibro_configuration, class: KalibroConfiguration do
    id 12
    name "Perl"
    description "Code metrics for Perl."
  end
end
