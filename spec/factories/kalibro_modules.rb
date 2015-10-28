FactoryGirl.define do
  factory :kalibro_module, class: KalibroClient::Entities::Processor::KalibroModule do
    name 'Qt-Calculator'
    granularity 'SOFTWARE'

    trait :package do
      granularity 'PACKAGE'
    end

    trait :class do
      granularity 'CLASS'
    end

    trait :function do
      granularity 'FUNCTION'
    end

    trait :method do
      granularity 'METHOD'
    end

    factory :kalibro_module_package, traits: [:package]
    factory :kalibro_module_class, traits: [:class]
    factory :kalibro_module_function, traits: [:function]
    factory :kalibro_module_method, traits: [:method]
  end
end
