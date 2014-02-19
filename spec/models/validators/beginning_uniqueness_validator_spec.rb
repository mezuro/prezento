require 'spec_helper'

describe BeginningUniquenessValidator do
  describe 'methods' do
    describe 'validate_each' do
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
      context 'without saved mezuro_range' do
        before :each do
          MezuroRange.expects(:ranges_of).with(metric_configuration.id).returns([])
          MezuroRange.expects(:request).returns(42)
        end

        subject { FactoryGirl.build(:mezuro_range, metric_configuration_id: metric_configuration.id) }
        it 'should contain no errors' do
          subject.save
          subject.errors.should be_empty
        end
      end

      context 'with beginning already taken by another mezuro_range' do
        let(:another_mezuro_range) { FactoryGirl.build(:another_mezuro_range, id: 3, metric_configuration_id: metric_configuration.id) }
        before :each do
          @subject = FactoryGirl.build(:mezuro_range, metric_configuration_id: metric_configuration.id)
          MezuroRange.expects(:ranges_of).with(@subject.metric_configuration_id).returns([another_mezuro_range])
        end

        it 'should contain errors' do
          @subject.save
          @subject.errors[:beginning].should eq(["There's already a MezuroRange with beginning #{@subject.beginning}! Please, choose another one."])
        end
      end
    end
  end
end
