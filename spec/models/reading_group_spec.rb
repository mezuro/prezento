require 'rails_helper'

describe ReadingGroup, :type => :model do
  describe 'methods' do
    describe 'persisted?' do
      before :each do
        @subject = FactoryGirl.build(:reading_group, :with_id)
      end
    end

    describe 'update' do
      before :each do
        @qt = FactoryGirl.build(:reading_group, :with_id)
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
      subject { FactoryGirl.build(:reading_group, :with_id) }
      let(:reading) { FactoryGirl.build(:reading_with_id) }

      it 'should call readings_of on the Reading model' do
        subject.expects(:readings).returns([reading])

        expect(subject.readings).to include(reading)
      end
    end
  end

  describe 'class methods' do
    describe 'public_or_owned_by_user' do
      let!(:user) { FactoryGirl.build(:user) }

      let!(:owned_private_attrs)     { FactoryGirl.build(:reading_group_attributes, :private, user_id: user.id) }
      let!(:owned_public_attrs)      { FactoryGirl.build(:reading_group_attributes,           user_id: user.id) }
      let!(:not_owned_private_attrs) { FactoryGirl.build(:reading_group_attributes, :private, user_id: user.id+1) }
      let!(:not_owned_public_attrs)  { FactoryGirl.build(:reading_group_attributes,           user_id: user.id+1) }

      let!(:public_attrs) { [owned_public_attrs, not_owned_public_attrs] }
      let(:public_reading_groups) { public_attrs.map(&:reading_group) }

      let!(:owned_or_public_attrs) { public_attrs + [owned_private_attrs] }
      let!(:owned_or_public_reading_groups) { owned_or_public_attrs.map(&:reading_group) }

      let(:all_reading_groups) { owned_or_public_reading_groups + [not_owned_private_attrs.reading_group] }

      context 'when reading groups exist' do
        before :each do
          # Make sure the reading groups are found when looked up by the Attributes by their id
          all_reading_groups.each do |reading_group|
            ReadingGroup.stubs(:find).with(reading_group.id).returns(reading_group)
          end

          ReadingGroupAttributes.expects(:where).with(public: true).returns(public_attrs)
        end

        context 'when user is not provided' do
          it 'should find all public reading groups' do
            expect(ReadingGroup.public).to eq(public_reading_groups)
          end
        end

        context 'when user is provided' do
          before do
            ReadingGroupAttributes.expects(:where).with(user_id: user.id, public: false).returns([owned_private_attrs])
          end

          it 'should find all public and owned reading groups' do
            p all_reading_groups

            expect(ReadingGroup.public_or_owned_by_user(user)).to eq(owned_or_public_reading_groups)
          end
        end
      end

      context 'when no reading groups exist' do
        before :each do
          # Map the reading group attributes to the corresponding Reading Group
          all_reading_groups.each do |reading_group|
            ReadingGroup.stubs(:find).with(reading_group.id).raises(KalibroClient::Errors::RecordNotFound)
          end

          ReadingGroupAttributes.expects(:where).with(public: true).returns(public_attrs)
        end

        it 'is expected to be empty' do
          expect(ReadingGroup.public).to be_empty
        end
      end
    end
  end
end
