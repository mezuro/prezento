require 'rails_helper'

describe ReadingGroup, :type => :model do
  describe 'methods' do
    describe 'persisted?' do
      before :each do
        @subject = FactoryGirl.build(:reading_group)
      end

      it 'should return false' do
        expect(@subject.persisted?).to eq(false)
      end
    end

    describe 'update' do
      before :each do
        @qt = FactoryGirl.build(:reading_group)
        @qt_params = Hash[FactoryGirl.attributes_for(:reading_group).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers
      end

      context 'with valid attributes' do
        before :each do
          @qt.expects(:save).with(@qt_params).returns(true)
        end

        it 'should return true' do
          expect(@qt.save(@qt_params)).to eq(true)
        end
      end

      context 'with invalid attributes' do
        before :each do
          @qt.expects(:save).with(@qt_params).returns(false)
        end

        it 'should return false' do
          expect(@qt.save(@qt_params)).to eq(false)
        end
      end
    end

    describe 'readings' do
      subject { FactoryGirl.build(:reading_group) }
      let(:reading) { FactoryGirl.build(:reading) }

      it 'should call readings_of on the Reading model' do
        subject.expects(:readings).returns([reading])

        expect(subject.readings).to include(reading)
      end
    end
  end
end
