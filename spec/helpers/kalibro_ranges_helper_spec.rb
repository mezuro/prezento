require 'rails_helper'

describe KalibroRangesHelper, :type => :helper do
  describe 'readings_options' do
    let(:reading) { FactoryGirl.build(:reading_with_id) }
    it 'should return a pair with the reading label and id' do
      expect(helper.readings_options([reading])).to eq [[reading.label, reading.id]]
    end
  end
end

