require 'rails_helper'

describe HotspotMetricConfigurationsController, :type => :controller do
  let(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, :with_id) }

  describe 'create' do
    let!(:metric_configuration) { FactoryGirl.build(:hotspot_metric_configuration) }
    let(:metric_configuration_params) { metric_configuration.to_hash }
    let(:metric_collector) { FactoryGirl.build(:metric_collector) }

    before do
      sign_in FactoryGirl.create(:user)
    end

    context 'when the current user owns the metric configuration' do
      before :each do
        KalibroConfiguration.expects(:find).with(kalibro_configuration.id).returns kalibro_configuration
        subject.expects(:kalibro_configuration_owner?).returns true
      end

      context 'with valid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(true)
          KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).with(metric_collector.name).returns(metric_collector)
          metric_collector.expects(:find_metric_by_code).with(metric_configuration.metric.code).returns(metric_configuration.metric)

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params, metric_collector_name: metric_collector.name, metric_code: metric_configuration.metric.code
        end

        it { is_expected.to respond_with(:redirect) }
      end

      context 'with invalid fields' do
        before :each do
          MetricConfiguration.any_instance.expects(:save).returns(false)
          KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).with(metric_collector.name).returns(metric_collector)
          metric_collector.expects(:find_metric_by_code).with(metric_configuration.metric.code).returns(metric_configuration.metric)

          post :create, kalibro_configuration_id: kalibro_configuration.id, metric_configuration: metric_configuration_params, metric_collector_name: metric_collector.name, metric_code: metric_configuration.metric.code
        end

        it { is_expected.to respond_with(:redirect) }
      end
    end
  end
end
