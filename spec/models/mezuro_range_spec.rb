require 'rails_helper'

describe MezuroRange, :type => :model do
  subject { FactoryGirl.build(:mezuro_range, { metric_configuration_id: 42 }) }
  describe 'validations' do
    context 'active model validations' do
      before :each do
        BeginningUniquenessValidator.any_instance.stubs(:validate_each)
        GreaterThanBeginningValidator.any_instance.stubs(:validate_each)
        RangeOverlappingValidator.any_instance.stubs(:validate)
      end

      it { is_expected.to validate_presence_of(:beginning) }
      it { is_expected.to validate_presence_of(:end) }
      it { is_expected.to validate_presence_of(:reading_id) }

      context 'beginning and end numericality' do
        it { is_expected.to validate_numericality_of(:beginning) }
        it { is_expected.to validate_numericality_of(:end) }

        it 'should allow -INF and INF to beginning' do
          subject.beginning = '-INF'
          subject.save

          expect(subject.errors.messages).to be_empty

          subject.beginning = 'INF'
          subject.save

          expect(subject.errors.messages).to be_empty
        end

        it 'should allow -INF and INF to end' do
          subject.end = '-INF'
          subject.save

          expect(subject.errors.messages).to be_empty

          subject.end = 'INF'
          subject.save

          expect(subject.errors.messages).to be_empty
        end
      end
    end

    context 'beginning validations' do
      before :each do
        GreaterThanBeginningValidator.any_instance.stubs(:validate_each)
        RangeOverlappingValidator.any_instance.stubs(:validate)
      end

      it 'should validate uniqueness' do
        BeginningUniquenessValidator.any_instance.expects(:validate_each).with(subject, :beginning, subject.beginning)
        subject.save
      end
    end

    context 'end validations' do
      before :each do
        BeginningUniquenessValidator.any_instance.stubs(:validate_each)
        RangeOverlappingValidator.any_instance.stubs(:validate)
      end

      it 'should validate that end is greater than beginning' do
        GreaterThanBeginningValidator.any_instance.expects(:validate_each).with(subject, :end, subject.end)
        subject.save
      end
    end

    context 'overlapping validations' do
      before :each do
        GreaterThanBeginningValidator.any_instance.stubs(:validate_each)
        BeginningUniquenessValidator.any_instance.stubs(:validate_each)
      end

      it 'is expected to validate if this range overlaps the existing ones' do
        RangeOverlappingValidator.any_instance.expects(:validate).with(subject)
        subject.save
      end
    end
  end
end