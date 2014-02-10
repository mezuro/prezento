require 'spec_helper'

pending 'TO FIX' do
  describe BeginningUniquenessValidator do
    describe 'methods' do    
      subject { FactoryGirl.build(:range) }
      describe 'validate_each' do
        context 'without saved mezuro_ranges' do
          before :each do
            MezuroRange.expects(:ranges_of).returns([])
            MezuroRange.expects(:request).returns(42)
          end

          it 'should contain no errors' do
            subject.save
            subject.errors.should be_empty
          end
        end
        let (:metric_configuration) { FactoryGirl.build(:metric_configuration) }
        context 'with beginning already taken by another mezuro_range' do
          before :each do
            MezuroRange.expects(:ranges_of).with(metric_configuration.id).returns([FactoryGirl.build(:metric_configuration, id: subject.id + 1)])
          end

          it 'should contain errors' do
            subject.save
            subject.errors[:beginning].should eq(["There's already a MezuroRange with beginning #{@subject.beginning}! Please, choose another one."])
          end
        end
      end
    end
  end
end