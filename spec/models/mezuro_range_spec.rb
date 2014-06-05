require 'spec_helper'

describe MezuroRange, :type => :model do
  subject { FactoryGirl.build(:mezuro_range, { metric_configuration_id: 42 }) }
  describe 'validations' do
    context 'active model validations' do
      before :each do
        MezuroRange.expects(:ranges_of).with(subject.metric_configuration_id).at_least_once.returns([])
      end

      it { is_expected.to validate_presence_of(:beginning) }
      it { is_expected.to validate_presence_of(:end) }
      it { is_expected.to validate_presence_of(:reading_id) }

      context 'beginning and end numericality' do
        it { is_expected.to validate_presence_of(:beginning) }
        it { is_expected.to validate_presence_of(:end) }

        it 'should allow -INF and INF to beginning' do
          subject.beginning = '-INF'
          subject.save

          expect(subject.errors.messages).to be_empty

          subject.beginning = 'INF'
          subject.save

          expect(subject.errors.messages).to be_empty
        end

        it 'should allow -INF and INF to end' do
          subject.end = '-INF'
          subject.save

          expect(subject.errors.messages).to be_empty

          subject.end = 'INF'
          subject.save

          expect(subject.errors.messages).to be_empty
        end
      end
    end
  end

  context 'beginning validations' do
    before :each do
      MezuroRange.expects(:request).returns(2)
    end

    it 'should validate uniqueness' do
      BeginningUniquenessValidator.any_instance.expects(:validate_each).with(subject, :beginning, subject.beginning)
      subject.save
    end
  end
end
