require "rails_helper"

describe KalibroRangesController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/kalibro_configurations/1/metric_configurations/1/kalibro_ranges').
                  to(controller: :kalibro_ranges, action: :index, kalibro_configuration_id: "1", metric_configuration_id: "1") }
    it { is_expected.to route(:post, '/kalibro_configurations/1/metric_configurations/1/kalibro_ranges').
                  to(controller: :kalibro_ranges, action: :create, kalibro_configuration_id: "1", metric_configuration_id: "1") }
    it { is_expected.to route(:get, '/kalibro_configurations/1/metric_configurations/1/kalibro_ranges/1/edit').
                  to(controller: :kalibro_ranges, action: :edit, kalibro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
    it { is_expected.to route(:get, '/kalibro_configurations/1/metric_configurations/1/kalibro_ranges/1').
                  to(controller: :kalibro_ranges, action: :show, kalibro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
    it { is_expected.to route(:delete, '/kalibro_configurations/1/metric_configurations/1/kalibro_ranges/1').
                  to(controller: :kalibro_ranges, action: :destroy, kalibro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
    it { is_expected.to route(:get, '/kalibro_configurations/1/metric_configurations/1/kalibro_ranges/new').
                  to(controller: :kalibro_ranges, action: :new, kalibro_configuration_id: "1", metric_configuration_id: "1") }
    it { is_expected.to route(:put, '/kalibro_configurations/1/metric_configurations/1/kalibro_ranges/1').
                  to(controller: :kalibro_ranges, action: :update, kalibro_configuration_id: "1", metric_configuration_id: "1", id: "1") }
  end
end
