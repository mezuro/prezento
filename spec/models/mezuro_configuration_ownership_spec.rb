require 'spec_helper'

describe MezuroConfigurationOwnership do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'methods' do
    describe 'mezuro_configuration' do
      subject {FactoryGirl.build(:mezuro_configuration_ownership)}
      let(:mezuro_configuration) {FactoryGirl.build(:mezuro_configuration)}

      it { should validate_presence_of(:mezuro_configuration_id) }

      it 'should return the mezuro_configuration' do
        MezuroConfiguration.expects(:find).with(subject.mezuro_configuration_id).returns(mezuro_configuration)
        subject.mezuro_configuration.should eq(mezuro_configuration)
      end

      it 'should fail to save with parent self' do
        subject.parent = subject
        subject.save
        subject.errors[:base].should_not be_empty
      end
    end
  end
end
