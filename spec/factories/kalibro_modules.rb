FactoryGirl.define do
  factory :kalibro_module, class: KalibroClient::Entities::Processor::KalibroModule do
    name 'Qt-Calculator'
    granularity { {'type' => 'SOFTWARE'} }

    trait :package do
      granularity { {'type' => 'PACKAGE'} }
    end

    trait :class do
      granularity { {'type' => 'CLASS'} }
    end

    trait :function do
      granularity { {'type' => 'FUNCTION'} }
    end

    trait :method do
      granularity { {'type' => 'METHOD'} }
    end

    factory :kalibro_module_package, traits: [:package]
    factory :kalibro_module_class, traits: [:class]
    factory :kalibro_module_function, traits: [:function]
    factory :kalibro_module_method, traits: [:method]

    initialize_with { KalibroClient::Entities::Processor::KalibroModule.new({granularity: granularity, name: name}.stringify_keys) }
  end
end
