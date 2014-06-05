require "spec_helper"

describe CompoundMetricConfigurationsController, :type => :routing do
  describe "routing" do
    it { is_expected.to route(:get, '/mezuro_configurations/1/compound_metric_configurations/new').
                  to(controller: :compound_metric_configurations, action: :new, mezuro_configuration_id: "1") }
    it { is_expected.to route(:get, '/mezuro_configurations/1/compound_metric_configurations').
                  to(controller: :compound_metric_configurations, action: :index, mezuro_configuration_id: "1") }
    it { is_expected.to route(:post, '/mezuro_configurations/1/compound_metric_configurations').
                  to(controller: :compound_metric_configurations, action: :create, mezuro_configuration_id: "1") }
    it { is_expected.to route(:get, '/mezuro_configurations/1/compound_metric_configurations/1').
                  to(controller: :compound_metric_configurations, action: :show, mezuro_configuration_id: "1", id: "1") }
    it { is_expected.to route(:get, '/mezuro_configurations/1/compound_metric_configurations/1/edit').
                  to(controller: :compound_metric_configurations, action: :edit, mezuro_configuration_id: "1", id: "1") }
    it { is_expected.to route(:put, '/mezuro_configurations/1/compound_metric_configurations/1').
                  to(controller: :compound_metric_configurations, action: :update, mezuro_configuration_id: "1", id: "1") }
    it { is_expected.not_to route(:delete, '/mezuro_configurations/1/compound_metric_configurations/1').
                  to(controller: :compound_metric_configurations, action: :destroy, mezuro_configuration_id: "1", id: "1") }
  end
end
