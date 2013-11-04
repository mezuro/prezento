require 'spec_helper'

describe ModuleResult do
  describe 'methods' do
    describe 'metric_results' do
      subject { FactoryGirl.build(:module_result) }

      it 'should call the metric_results_of method' do
        KalibroEntities::Entities::MetricResult.expects(:metric_results_of).with(subject.id).returns(nil)

        subject.metric_results
      end
    end
  end
end