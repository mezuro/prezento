require 'rails_helper'

describe Repository, :type => :model do
  describe 'methods' do
    describe 'last_processing_of' do
      subject { FactoryGirl.build(:repository) }

      context 'with no processing at all' do
        before :each do
          subject.expects(:has_processing).returns(false)
        end

        it 'should return nil' do
          expect(subject.last_processing_of).to be_nil
        end
      end

      context 'with a processing' do
        let(:processing) { FactoryGirl.build(:processing) }

        before :each do
          subject.expects(:has_processing).returns(true)
        end

        it 'should return a ready processing processing' do
          subject.expects(:last_processing).returns(processing)

          expect(subject.last_processing_of).to eq(processing)
        end
      end
    end
  end
end
