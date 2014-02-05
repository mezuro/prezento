require 'spec_helper'

describe MetricConfigurationsHelper do
  describe 'aggregation_form_options' do
    it 'should return an array with the supported aggregation forms' do
      helper.aggregation_options.should eq [["Average","AVERAGE"], ["Median", "MEDIAN"], ["Maximum", "MAXIMUM"], ["Minimum", "MINIMUM"],
      ["Count", "COUNT"], ["Standard Deviation", "STANDARD_DEVIATION"]]
    end
  end
end
