require 'spec_helper'

describe Repository do
  describe 'methods' do
    describe 'last_processing' do
      subject { FactoryGirl.build(:repository) }

      context 'with no processing at all' do
        before :each do
          Processing.expects(:has_processing).with(subject.id).returns(false)
        end

        it 'should return nil' do
          subject.last_processing.should be_nil
        end
      end

      context 'with a ready processing' do
        let(:processing) { FactoryGirl.build(:processing) }

        before :each do
          Processing.expects(:has_processing).with(subject.id).returns(true)
          Processing.expects(:has_ready_processing).with(subject.id).returns(true)
        end

        it 'should return a ready processing processing' do
          Processing.expects(:last_ready_processing_of).with(subject.id).returns(processing)

          subject.last_processing.should eq(processing)
        end
      end

      context 'with no ready processing' do
        let(:processing) { FactoryGirl.build(:processing, state: 'COLLECTING') }

        before :each do
          Processing.expects(:has_processing).with(subject.id).returns(true)
          Processing.expects(:has_ready_processing).with(subject.id).returns(false)
        end

        it 'should return the latest processing' do
          Processing.expects(:last_processing_of).with(subject.id).returns(processing)

          subject.last_processing.should eq(processing)
        end
      end
    end
  end

  describe 'validations' do
    subject {FactoryGirl.build(:repository)}

    context 'active model validations' do
      before :each do
        Repository.expects(:all).at_least_once.returns([])
      end

      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:address) }
    end

    context 'kalibro validations' do
      before :each do
        Repository.expects(:request).returns(42)
      end

      it 'should validate uniqueness' do
        KalibroUniquenessValidator.any_instance.expects(:validate_each).with(subject, :name, subject.name)
        subject.save
      end
    end
  end
end
