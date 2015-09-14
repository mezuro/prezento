FactoryGirl.define do
  factory :kalibro_module, class: KalibroClient::Entities::Processor::KalibroModule do
    name 'Qt-Calculator'
    granlrty 'SOFTWARE'

    trait :package do
      granlrty 'PACKAGE'
    end

    trait :class do
      granlrty 'CLASS'
    end

    trait :function do
      granlrty 'FUNCTION'
    end

    trait :method do
      granlrty 'METHOD'
    end

    factory :kalibro_module_package, traits: [:package]
    factory :kalibro_module_class, traits: [:class]
    factory :kalibro_module_function, traits: [:function]
    factory :kalibro_module_method, traits: [:method]
  end
end
