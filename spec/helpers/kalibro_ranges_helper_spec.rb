require 'rails_helper'

describe KalibroRangesHelper, :type => :helper do
  describe 'readings_options' do
    let(:reading) { FactoryGirl.build(:reading_with_id) }
    it 'should return a pair with the reading label and id' do
      expect(helper.readings_options([reading])).to eq [[reading.label, reading.id]]
    end
  end

  describe 'format_boundary' do
    context 'with a finite value' do
      let(:value) { 10 }

      it 'is expected to return the value itself' do
        expect(helper.format_boundary(value)).to eq(value)
      end
    end

    context 'with positive infinity value' do
      let(:value) { Float::INFINITY }

      it 'is expected to return the string "INF"' do
        expect(helper.format_boundary(value)).to eq("INF")
      end
    end

    context 'with negative infinity value' do
      let(:value) { -Float::INFINITY }

      it 'is expected to return the string "-INF"' do
        expect(helper.format_boundary(value)).to eq("-INF")
      end
    end
  end
end

