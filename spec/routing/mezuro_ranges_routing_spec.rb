require "spec_helper"

describe MezuroRangesController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges').
                  to(controller: :mezuro_ranges, action: :index, mezuro_configuration_id: "1", metric_configuration_id: "1") }
    it { is_expected.to route(:post, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges').
                  to(controller: :mezuro_ranges, action: :create, mezuro_configuration_id: "1", metric_configuration_id: "1") }
    it { is_expected.to route(:get, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/1/edit').
                  to(controller: :mezuro_ranges, action: :edit, mezuro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
    it { is_expected.to route(:get, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/1').
                  to(controller: :mezuro_ranges, action: :show, mezuro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
    it { is_expected.to route(:delete, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/1').
                  to(controller: :mezuro_ranges, action: :destroy, mezuro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
    it { is_expected.to route(:get, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/new').
                  to(controller: :mezuro_ranges, action: :new, mezuro_configuration_id: "1", metric_configuration_id: "1") }
    it { is_expected.to route(:put, '/mezuro_configurations/1/metric_configurations/1/mezuro_ranges/1').
                  to(controller: :mezuro_ranges, action: :update, mezuro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
  end
end
