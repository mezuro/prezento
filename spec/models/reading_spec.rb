require 'rails_helper'

describe Reading, :type => :model do
  pending 'waiting for kalibro configurations integration' do
    describe 'validations' do
      subject {FactoryGirl.build(:reading)}

      context 'active model validations' do
        before :each do
          Reading.expects(:all).at_least_once.returns([])
        end

        it { is_expected.to validate_presence_of(:label) }
        it { is_expected.to validate_presence_of(:color) }
        it { is_expected.to validate_presence_of(:grade) }
        it { is_expected.to validate_numericality_of(:grade) }
      end

      context 'kalibro validations' do
        before :each do
          Reading.expects(:request).returns(42)
        end

        it 'should validate uniqueness' do
          KalibroUniquenessValidator.any_instance.expects(:validate_each).with(subject, :label, subject.label)
          subject.save
        end
      end
    end
  end
end
