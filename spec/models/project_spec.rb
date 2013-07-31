require 'spec_helper'

describe Project do
  describe 'methods' do
    describe 'persisted?' do
      it 'should return false' do
        subject.persisted?.should eq(false)
      end
    end
  end
end
