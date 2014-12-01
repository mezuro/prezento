require 'rails_helper'

describe ModuleResult, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:module_result) }
    
    describe 'metric_history' do
      let(:date_module_result) {FactoryGirl.build(:date_module_result)}
      let(:metric_result) {FactoryGirl.build(:metric_result)}
      let(:processing) {FactoryGirl.build(:processing)}
      let(:repository) {FactoryGirl.build(:repository)}

      before :each do
        subject.expects(:processing).returns(processing)
        processing.expects(:repository).returns(repository)
        repository.expects(:module_result_history_of).with(subject).returns([date_module_result])
        ModuleResult.any_instance.expects(:metric_results).returns([metric_result])
      end

      it 'should return the history for the given metric name' do
        expect(subject.metric_history(metric_result.metric_configuration_snapshot.metric.name)).to eq({date_module_result.date => metric_result.value})
      end
    end
  end
end
