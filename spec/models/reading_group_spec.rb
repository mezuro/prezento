require 'spec_helper'

describe ReadingGroup do
  describe 'methods' do
    describe 'persisted?' do
      before :each do
        @subject = FactoryGirl.build(:reading_group)
        ReadingGroup.expects(:exists?).with(@subject.id).returns(false)
      end

      it 'should return false' do
        @subject.persisted?.should eq(false)
      end
    end
    
    describe 'update' do
      before :each do
        @qt = FactoryGirl.build(:reading_group)
        @qt_params = Hash[FactoryGirl.attributes_for(:reading_group).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers
      end

      context 'with valid attributes' do
        before :each do
          @qt.expects(:save).returns(true)
        end

        it 'should return true' do
          @qt.update(@qt_params).should eq(true)
        end
      end

      context 'with invalid attributes' do
        before :each do
          @qt.expects(:save).returns(false)
        end

        it 'should return false' do
          @qt.update(@qt_params).should eq(false)
        end
      end
    end

    describe 'readings' do
      subject { FactoryGirl.build(:reading_group) }
      let(:reading) { FactoryGirl.build(:reading) }

      it 'should call readings_of on the Reading model' do
        Reading.expects(:readings_of).with(subject.id).returns([reading])

        subject.readings.should include(reading)
      end
    end
  end

  describe 'validations' do
    subject {FactoryGirl.build(:reading_group)}
    context 'active model validations' do  
      before :each do
        ReadingGroup.expects(:all).at_least_once.returns([])
      end
      it { should validate_presence_of(:name) }
    end

    context 'kalibro validations' do
      before :each do
        ReadingGroup.expects(:request).returns(42)
      end

      it 'should validate uniqueness' do
        KalibroUniquenessValidator.any_instance.expects(:validate_each).with(subject, :name, subject.name)
        subject.save
      end
    end
  end
end
