require "rails_helper"

describe MetricConfigurationsController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:post, '/kalibro_configurations/1/metric_configurations/new').
                  to(controller: :metric_configurations, action: :new, kalibro_configuration_id: "1") }
    it { is_expected.to route(:get, '/kalibro_configurations/1/metric_configurations').
                  to(controller: :metric_configurations, action: :index, kalibro_configuration_id: "1") }
    it { is_expected.to route(:post, '/kalibro_configurations/1/metric_configurations').
                  to(controller: :metric_configurations, action: :create, kalibro_configuration_id: "1") }
    it { is_expected.to route(:get, '/kalibro_configurations/1/metric_configurations/1').
                  to(controller: :metric_configurations, action: :show, kalibro_configuration_id: "1", id: "1") }
    it { is_expected.to route(:get, '/kalibro_configurations/1/metric_configurations/1/edit').
                  to(controller: :metric_configurations, action: :edit, kalibro_configuration_id: "1", id: "1") }
    it { is_expected.to route(:put, '/kalibro_configurations/1/metric_configurations/1').
                  to(controller: :metric_configurations, action: :update, kalibro_configuration_id: "1", id: "1") }
    it { is_expected.to route(:delete, '/kalibro_configurations/1/metric_configurations/1').
                  to(controller: :metric_configurations, action: :destroy, kalibro_configuration_id: "1", id: "1") }
    it { is_expected.to route(:get, '/kalibro_configurations/1/metric_configurations/choose_metric').
                  to(controller: :metric_configurations, action: :choose_metric, kalibro_configuration_id: "1") }
  end
end
