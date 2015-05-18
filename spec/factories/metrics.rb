FactoryGirl.define do
  factory :metric, class: KalibroClient::Entities::Miscellaneous::NativeMetric do
    name "Total Abstract Classes"
    code "total_abstract_classes"
    scope "SOFTWARE"
    description nil
    languages { [:C] }
    metric_collector_name "Analizo"

    initialize_with { new(name, code, scope, description, languages) }
  end

  factory :loc, class: KalibroClient::Entities::Miscellaneous::NativeMetric do
    name "Lines of Code"
    code "loc"
    scope "CLASS"
    description nil
    languages { [:C] }
    metric_collector_name "Analizo"

    initialize_with { new(name, code, scope, description, languages) }
  end

  factory :pain, class: KalibroClient::Entities::Miscellaneous::NativeMetric do
    name "Code Pain"
    code "flog"
    scope "METHOD"
    description nil
    languages { [:ruby] }
    metric_collector_name "MetricFu"

    initialize_with { new(name, code, scope, description, languages) }
  end

  factory :saikuro, class: KalibroClient::Entities::Miscellaneous::NativeMetric do
    name "Cyclomatic Complexity"
    code "saikuro"
    scope "METHOD"
    description nil
    languages { [:ruby] }
    metric_collector_name "MetricFu"

    initialize_with { new(name, code, scope, description, languages) }
  end

  factory :compound_metric, class: KalibroClient::Entities::Miscellaneous::CompoundMetric do
    name "Compound"
    code "compound"
    scope "CLASS"
    description nil
    script "return 2;"

    initialize_with { new(name, code, scope, script) }
  end
end
