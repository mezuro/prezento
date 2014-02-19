require 'spec_helper'

describe MezuroRangesHelper do
  describe 'readings_options' do
    let(:reading) { FactoryGirl.build(:reading) }
    it 'should return a pair with the reading label and id' do
      helper.readings_options([reading]).should eq [[reading.label, reading.id]]
    end
  end
end

