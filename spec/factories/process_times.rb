FactoryGirl.define do
  factory :process_time, class: KalibroGatekeeperClient::Entities::ProcessTime do
    state "Ready"
    time  "3600"
  end

  factory :analyzing_process_time, class: KalibroGatekeeperClient::Entities::ProcessTime do
    state "Analyzing"
    time  "12345"
  end
end