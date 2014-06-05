require 'rails_helper'

describe Processing, :type => :model do
  describe 'methods' do
    subject { FactoryGirl.build(:processing) }

    describe 'ready?' do
      context 'with a READY processing' do
        it 'should return true' do
          expect(subject.ready?).to be_truthy
        end
      end

      context 'without a READY processing' do
        subject { FactoryGirl.build(:processing, state: 'COLLECTING') }

        it 'should return false' do
          expect(subject.ready?).to be_falsey
        end
      end
    end

    describe 'root_module_result' do
      it 'should call the root_module_result method' do
        ModuleResult.expects(:find).with(subject.results_root_id).returns(FactoryGirl.build(:module_result))

        subject.root_module_result
      end
    end
  end
end