require 'spec_helper'

describe MezuroRangesHelper, :type => :helper do
  describe 'readings_options' do
    let(:reading) { FactoryGirl.build(:reading) }
    it 'should return a pair with the reading label and id' do
      expect(helper.readings_options([reading])).to eq [[reading.label, reading.id]]
    end
  end
end

