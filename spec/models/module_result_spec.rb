require 'rails_helper'

describe ModuleResult, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:module_result) }

    describe 'metric_history', pending: 'broke after kalibro client major update' do
      let(:date_module_result) {FactoryGirl.build(:date_module_result)}
      let(:metric_configuration) { FactoryGirl.build(:another_metric_configuration_with_id) }
      let!(:metric_result) { FactoryGirl.build(:metric_result, metric_configuration: metric_configuration) }
      let(:processing) {FactoryGirl.build(:processing)}

      before :each do
        subject.expects(:processing).returns(processing)
        date_module_result.expects(:metric_result).returns(metric_result)
        KalibroClient::Entities::Processor::MetricResult.expects(:history_of).with(metric_configuration.metric.name, subject.id, processing.repository_id).returns([date_module_result])
      end

      it 'should return the history for the given metric name' do
        expect(subject.metric_history(metric_configuration.metric.name)).to eq({date_module_result.date => metric_result.value})
      end
    end
  end
end
