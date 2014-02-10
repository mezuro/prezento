require 'spec_helper'

describe CodeUniquenessValidator do
  describe 'methods' do
    describe 'validate_each' do
      context 'without saved metric_configurations' do
        before :each do
          MetricConfiguration.expects(:metric_configurations_of).returns([])
          MetricConfiguration.expects(:request).returns(42)
        end

        subject { FactoryGirl.build(:metric_configuration) }
        it 'should contain no errors' do
          subject.save
          subject.errors.should be_empty
        end
      end

      context 'with code already taken by another metric_configuration' do
        before :each do
          @subject = FactoryGirl.build(:metric_configuration)
          MetricConfiguration.expects(:metric_configurations_of).with(@subject.configuration_id).returns([FactoryGirl.build(:metric_configuration, id: @subject.id + 1)])
        end

        it 'should contain errors' do
          @subject.save
          @subject.errors[:code].should eq(["There's already a MetricConfiguration with code #{@subject.code}! Please, choose another one."])
        end
      end
    end
  end
end