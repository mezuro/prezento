require 'rails_helper'

describe ReadingGroup, :type => :model do
  describe 'methods' do
    describe 'persisted?' do
      before :each do
        @subject = FactoryGirl.build(:reading_group_with_id)
      end
    end

    describe 'update' do
      before :each do
        @qt = FactoryGirl.build(:reading_group_with_id)
        @qt_params = @qt.to_hash
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
      subject { FactoryGirl.build(:reading_group_with_id) }
      let(:reading) { FactoryGirl.build(:reading_with_id) }

      it 'should call readings_of on the Reading model' do
        subject.expects(:readings).returns([reading])

        expect(subject.readings).to include(reading)
      end
    end
  end
end
