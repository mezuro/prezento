FactoryGirl.define do
  factory :metric, class: KalibroEntities::Entities::Metric do
    name "Total Abstract Classes"
    compound false
    scope "SOFTWARE"
    description nil
    script ""
    language ["C", "CPP", "JAVA"]
  end

  factory :loc, class: KalibroEntities::Entities::Metric do
    name "Lines of Code"
    compound false
    scope "CLASS"
    description nil
    script ""
    language ["C", "CPP", "JAVA"]
  end
end