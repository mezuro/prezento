FactoryGirl.define do
  factory :metric, class: KalibroGatekeeperClient::Entities::Metric do
    name "Total Abstract Classes"
    compound false
    scope "SOFTWARE"
    description nil
    script ""
    language ["C", "CPP", "JAVA"]
  end

  factory :loc, class: KalibroGatekeeperClient::Entities::Metric do
    name "Lines of Code"
    compound false
    scope "CLASS"
    description nil
    script ""
    language ["C", "CPP", "JAVA"]
  end

  factory :compound_metric, class: KalibroGatekeeperClient::Entities::Metric do
    name "Compound"
    compound true
    scope "CLASS"
    description nil
    script ""
    language ["C", "CPP", "JAVA"]
  end
end