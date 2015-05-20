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
      def build_attrs(rg_iter, *traits, **params)
        reading_group = rg_iter.next
        attr = FactoryGirl.build(:reading_group_attributes, *traits, params.merge(reading_group: reading_group))
        reading_group.stubs(:attributes).returns(attr)
        attr
      end

      let!(:reading_groups) { FactoryGirl.build_list(:reading_group, 4, :with_id) }
      let!(:rgs_iter) { reading_groups.each }

      let!(:one_user) { FactoryGirl.build(:user) }
      let!(:other_user) { FactoryGirl.build(:another_user) }

      let!(:ones_private_attrs) { build_attrs(rgs_iter, :private, user: one_user) }
      let!(:others_private_attrs) { build_attrs(rgs_iter, :private, user: other_user) }
      let!(:ones_public_attrs) { build_attrs(rgs_iter, user: one_user) }
      let!(:others_public_attrs) { build_attrs(rgs_iter, user: other_user) }

      let!(:public_attrs) { [ones_public_attrs, others_public_attrs] }
      let(:public_reading_groups) { public_attrs.map(&:reading_group) }

      let(:ones_or_public_attrs) { public_attrs + [ones_private_attrs] }
      let(:ones_or_public_reading_groups) { ones_or_public_attrs.map(&:reading_group) }

      context 'when the reading group exists' do
        before :each do
          # Map the reading group attributes to the corresponding Reading Group
          reading_groups.each do |rg|
            ReadingGroup.stubs(:find).with(rg.id).returns(rg)
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
            ReadingGroupAttributes.expects(:where).with(user_id: one_user.id, public: false).returns([ones_private_attrs])
          end

          it 'should find all public and owned reading groups' do
            expect(ReadingGroup.public_or_owned_by_user(one_user)).to eq(ones_or_public_reading_groups)
          end
        end
      end

      context 'when the reading group does not' do
        before :each do
          # Map the reading group attributes to the corresponding Reading Group
          reading_groups.each do |rg|
            ReadingGroup.stubs(:find).with(rg.id).raises(KalibroClient::Errors::RecordNotFound)
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
