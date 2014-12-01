FactoryGirl.define do
  factory :metric, class: KalibroClient::Processor::Metric do
    name "Total Abstract Classes"
    code "total_abstract_classes"
    compound false
    scope "SOFTWARE"
    description nil

    initialize_with { new(compound, name, code, scope) }
  end

  factory :loc, class: KalibroClient::Processor::Metric do
    name "Lines of Code"
    code "loc"
    compound false
    scope "CLASS"
    description nil

    initialize_with { new(compound, name, code, scope) }
  end

  factory :compound_metric, class: KalibroClient::Processor::Metric do
    name "Compound"
    code "compound"
    compound true
    scope "CLASS"
    description nil
    script ""
    language ["C", "CPP", "JAVA"]

    initialize_with { new(compound, name, code, scope) }
  end
end
