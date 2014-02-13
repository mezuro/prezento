require 'spec_helper'

describe MezuroRange do
  describe 'validations' do
    subject { FactoryGirl.build(:mezuro_range, { metric_configuration_id: 42 }) }

    context 'active model validations' do
      before :each do
        MezuroRange.expects(:ranges_of).with(subject.metric_configuration_id).at_least_once.returns([])
      end
      
      it { should validate_presence_of(:beginning) }
      it { should validate_presence_of(:end) }
      it { should validate_presence_of(:reading_id) }
    end
  end
  pending "discuss about save method" do
    context 'beginning validations' do
      before :each do
        MezuroRange.expects(:request).returns(42)
      end

      it 'should validate uniqueness' do
        BeginningUniquenessValidator.any_instance.expects(:validate_each).with(subject, :beginning, subject.beginning)
        subject.save #TODO: needs to recieve subject.save(metric_configuration_id)
      end
    end
  end
end
