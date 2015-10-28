require 'rails_helper'

describe ModuleResult, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:module_result) }

    describe 'metric_history' do
      let(:date_metric_result) {FactoryGirl.build(:date_metric_result)}
      let(:metric_configuration) { FactoryGirl.build(:another_metric_configuration_with_id) }
      let!(:tree_metric_result) { FactoryGirl.build(:tree_metric_result, metric_configuration: metric_configuration) }
      let(:processing) {FactoryGirl.build(:processing)}

      before :each do
        subject.expects(:processing).returns(processing)
        date_metric_result.expects(:metric_result).returns(tree_metric_result)
        KalibroClient::Entities::Processor::TreeMetricResult.expects(:history_of).with(metric_configuration.metric.name, subject.id, processing.repository_id).returns([date_metric_result])
      end

      it 'should return the history for the given metric name' do
        expect(subject.metric_history(metric_configuration.metric.name)).to eq({date_metric_result.date => tree_metric_result.value})
      end
    end
  end
end
