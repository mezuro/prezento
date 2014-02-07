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

  describe 'native_metrics_of' do
    let! (:metric_configuration) { FactoryGirl.build(:metric_configuration) }

    before :each do
      MetricConfiguration.expects(:metric_configurations_of).with(metric_configuration.configuration_id).returns([metric_configuration])
    end

    it 'should return a pair with the metric configuration code and metric name' do
      helper.native_metrics_of(metric_configuration.configuration_id).should eq [[metric_configuration.code, metric_configuration.metric.name]]
    end
  end
end
