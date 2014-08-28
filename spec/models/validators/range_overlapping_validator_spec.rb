require 'rails_helper'

describe RangeOverlappingValidator, :type => :model do
  describe 'methods' do
    describe 'validate' do
      let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
      let(:range) { FactoryGirl.build(:mezuro_range, beginning: '-INF', end: 0.0, metric_configuration_id: metric_configuration.id) }

      before :each do
        BeginningUniquenessValidator.any_instance.stubs(:validate_each)
        GreaterThanBeginningValidator.any_instance.stubs(:validate_each)
      end

      context 'not overlapping' do
        let!(:not_overlapping_range) { FactoryGirl.build(:mezuro_range, id: 31, beginning: 0.0, end: 'INF', metric_configuration_id: metric_configuration.id) }

        before :each do
          MezuroRange.expects(:ranges_of).with(metric_configuration.id).returns([range, not_overlapping_range])
        end

        it 'is expected to not return errors' do
          range.save
          expect(range.errors).to be_empty
        end
      end


      context 'overlapping' do
        let!(:overlapping_range) { FactoryGirl.build(:mezuro_range, id: 31, beginning: '-INF', end: 'INF', metric_configuration_id: metric_configuration.id) }

        before :each do
          MezuroRange.expects(:ranges_of).with(metric_configuration.id).returns([range, overlapping_range])
        end

        it 'is expected to return errors' do
          range.save
          expect(range.errors[:beginning]).to eq(["There's already a #{range.class} within these boundaries! Please, choose another ones."])
        end
      end
    end
  end
end
