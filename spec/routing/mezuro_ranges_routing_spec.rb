require "spec_helper"

describe MezuroRangesController do
  describe "routing" do
    it { should route(:get, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges').
                  to(controller: :mezuro_ranges, action: :index, mezuro_configuration_id: "1", metric_configuration_id: "1") }
    it { should route(:post, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges').
                  to(controller: :mezuro_ranges, action: :create, mezuro_configuration_id: "1", metric_configuration_id: "1") }
    it { should route(:get, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/1/edit').
                  to(controller: :mezuro_ranges, action: :edit, mezuro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
    it { should route(:get, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/1').
                  to(controller: :mezuro_ranges, action: :show, mezuro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
    it { should route(:delete, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/1').
                  to(controller: :mezuro_ranges, action: :destroy, mezuro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
    it { should route(:get, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/new').
                  to(controller: :mezuro_ranges, action: :new, mezuro_configuration_id: "1", metric_configuration_id: "1") }
    it { should route(:put, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/1').
                  to(controller: :mezuro_ranges, action: :update, mezuro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
  end
end
