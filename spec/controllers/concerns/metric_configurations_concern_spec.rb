require 'rails_helper'

describe MetricConfigurationsConcern, type: :controller do
  describe 'set_metric_configuration' do
    let! (:metric_configuration){ FactoryGirl.build(:metric_configuration_with_id) }
    let! (:metric_configurations_controller) { MetricConfigurationsController.new }

    before :each do
      MetricConfiguration.expects(:find).with(metric_configuration.id).returns(metric_configuration)
      metric_configurations_controller.params = {id: metric_configuration.id}
    end

    it 'should assign metric_configuration' do
      metric_configurations_controller.set_metric_configuration
    end
  end
end
