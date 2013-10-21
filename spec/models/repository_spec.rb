require 'spec_helper'

describe Repository do
  describe 'methods' do
    describe 'last_processing' do
      subject { FactoryGirl.build(:repository) }

      context 'with a ready processing' do
        let(:processing) { FactoryGirl.build(:processing) }

        before :each do
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
          Processing.expects(:has_ready_processing).with(subject.id).returns(false)
        end

        it 'should return the latest processing' do
          Processing.expects(:last_processing_of).with(subject.id).returns(processing)

          subject.last_processing.should eq(processing)
        end
      end
    end
  end
end
