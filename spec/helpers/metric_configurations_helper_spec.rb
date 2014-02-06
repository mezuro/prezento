require 'spec_helper'

describe MetricConfigurationsHelper do
  describe 'aggregation_form_options' do
    it 'should return an array with the supported aggregation forms' do
      helper.aggregation_options.should eq [["Average","AVERAGE"], ["Median", "MEDIAN"], ["Maximum", "MAXIMUM"], ["Minimum", "MINIMUM"],
      ["Count", "COUNT"], ["Standard Deviation", "STANDARD_DEVIATION"]]
    end
  end

  describe 'reading_group_options' do
    let! (:reading_group) { FactoryGirl.build(:reading_group) }

    before :each do
      ReadingGroup.expects(:all).returns([reading_group])
    end

    it 'should return a pair with the reading group name and id' do
      helper.reading_group_options.should eq [[reading_group.name, reading_group.id]]
    end
  end
end
