require 'spec_helper'

describe MezuroConfigurationOwnership do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'methods' do
    describe 'mezuro_configuration' do
      subject {FactoryGirl.build(:mezuro_configuration_ownership)}
      let(:mezuro_configuration) {FactoryGirl.build(:mezuro_configuration)}

      before :each do
        MezuroConfiguration.expects(:find).with(subject.mezuro_configuration_id).returns(mezuro_configuration)
      end

      it 'should return the mezuro_configuration' do
        subject.mezuro_configuration.should eq(mezuro_configuration)
      end
    end
  end
end
