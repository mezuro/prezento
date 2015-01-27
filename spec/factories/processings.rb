FactoryGirl.define do
  factory :processing, class: Processing do
    id "31"
    date "2011-10-20T18:26:43.151+00:00"
    state "READY"
    root_module_result_id "13"

    trait :errored do
      state "ERROR"
    end

    factory :errored_processing, traits: [:errored]
  end
end
