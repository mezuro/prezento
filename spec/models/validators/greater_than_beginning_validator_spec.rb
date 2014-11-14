require 'rails_helper'

describe GreaterThanBeginningValidator, :type => :model do
  pending 'waiting for kalibro configurations integration' do
    describe 'methods' do
      describe 'validate_each' do
        before :each do
          BeginningUniquenessValidator.any_instance.stubs(:validate_each)
          RangeOverlappingValidator.any_instance.stubs(:validate)
        end
        context 'when beginning is INF or end is -INF' do
          subject { FactoryGirl.build(:mezuro_range, end: "-INF") }
          it 'is expected to return an error' do
            subject.save
            expect(subject.errors[:end]).to eq(["The End value should be greater than the Beginning value."])
          end
        end
        context 'when beginning is -INF or end is INF' do
          subject { FactoryGirl.build(:mezuro_range, end: "INF") }
          it 'is expected to not return an error' do
            subject.save
            expect(subject.errors[:end]).to be_empty
          end
        end
        context 'when beginning is greater than end' do
          subject { FactoryGirl.build(:mezuro_range, beginning: 1.0, end: 0.0) }
          it 'is expected to return an error' do
            subject.save
            expect(subject.errors[:end]).to eq(["The End value should be greater than the Beginning value."])
          end
        end
        context 'when beginning is smaller than end' do
          subject { FactoryGirl.build(:mezuro_range) }
          it 'is expected to not return an error' do
            subject.save
            expect(subject.errors[:end]).to be_empty
          end
        end
      end
    end
  end
end
