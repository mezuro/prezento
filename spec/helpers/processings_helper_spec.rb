require 'spec_helper'

describe ProcessingsHelper do
  describe 'humanize_eplased_time' do
    it 'should convert it to readable words' do
      helper.humanize_eplased_time(6000).should eq('less than a minute')
    end
  end
end