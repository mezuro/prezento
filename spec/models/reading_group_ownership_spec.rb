require 'spec_helper'

describe ReadingGroupOwnership do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'methods' do
    describe 'reading_group' do
      subject {FactoryGirl.build(:reading_group_ownership)}
      let(:reading_group) {FactoryGirl.build(:reading_group)}

      before :each do
        ReadingGroup.expects(:find).with(subject.reading_group_id).returns(reading_group)
      end

      it 'should return the reading_group' do
        subject.reading_group.should eq(reading_group)
      end
    end
  end
end
