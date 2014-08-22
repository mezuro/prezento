FactoryGirl.define do
  factory :metric, class: KalibroGatekeeperClient::Entities::Metric do
    name "Total Abstract Classes"
    code "total_abstract_classes"
    compound false
    scope "SOFTWARE"
    description nil
    script ""
    language ["C", "CPP", "JAVA"]
  end

  factory :loc, class: KalibroGatekeeperClient::Entities::Metric do
    name "Lines of Code"
    code "loc"
    compound false
    scope "CLASS"
    description nil
    script ""
    language ["C", "CPP", "JAVA"]
  end

  factory :compound_metric, class: KalibroGatekeeperClient::Entities::Metric do
    name "Compound"
    code "compound"
    compound true
    scope "CLASS"
    description nil
    script ""
    language ["C", "CPP", "JAVA"]
  end
end