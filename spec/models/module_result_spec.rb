require 'spec_helper'

describe ModuleResult, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:module_result) }
    
    describe 'metric_results' do
      it 'should call the metric_results_of method' do
        KalibroGatekeeperClient::Entities::MetricResult.expects(:metric_results_of).with(subject.id).returns(nil)

        subject.metric_results
      end
    end

    describe 'history' do
      before :each do
        ModuleResult.expects(:history_of).with(subject.id).returns([FactoryGirl.build(:date_module_result)])
      end

      it 'should return a array of DateModuleResults' do
        expect(subject.history.first).to be_a(DateModuleResult)
      end
    end

    describe 'metric_history' do
      let(:date_module_result) {FactoryGirl.build(:date_module_result)}
      let(:metric_result) {FactoryGirl.build(:metric_result)}

      before :each do
        subject.expects(:history).returns([date_module_result])
        ModuleResult.any_instance.expects(:metric_results).returns([metric_result])
      end

      it 'should return the history for the given metric name' do
        expect(subject.metric_history(metric_result.metric_configuration_snapshot.metric.name)).to eq({date_module_result.date => metric_result.value})
      end
    end
  end
end