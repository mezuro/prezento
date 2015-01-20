FactoryGirl.define do
  factory :metric, class: KalibroClient::Entities::Processor::NativeMetric do
    name "Total Abstract Classes"
    code "total_abstract_classes"
    scope "SOFTWARE"
    description nil
    languages { [:C] }

    initialize_with { new(name, code, scope, description, languages) }
  end

  factory :loc, class: KalibroClient::Entities::Processor::NativeMetric do
    name "Lines of Code"
    code "loc"
    scope "CLASS"
    description nil
    languages { [:C] }

    initialize_with { new(name, code, scope, description, languages) }
  end

  factory :compound_metric, class: KalibroClient::Entities::Processor::CompoundMetric do
    name "Compound"
    code "compound"
    scope "CLASS"
    description nil
    script ""

    initialize_with { new(name, code, scope, description, script) }
  end
end
