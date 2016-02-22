require 'rails_helper'

describe MetricConfigurationsHelper, :type => :helper do
  describe 'aggregation_form_options' do
    it 'should return an array with the supported aggregation forms' do
      expect(helper.aggregation_options).to eq [["Mean","MEAN"], ["Median", "MEDIAN"], ["Maximum", "MAXIMUM"], ["Minimum", "MINIMUM"],
      ["Standard Deviation", "STANDARD_DEVIATION"], ["Count", "COUNT"]]
    end
  end

  describe 'reading_group_options' do
    let! (:reading_group) { FactoryGirl.build(:reading_group, :with_id) }

    before :each do
      ReadingGroup.expects(:all).returns([reading_group])
    end

    it 'should return a pair with the reading group name and id' do
      expect(helper.reading_group_options).to eq [[reading_group.name, reading_group.id]]
    end
  end

  describe 'native_metrics_of' do
    let! (:metric_configuration) { FactoryGirl.build(:metric_configuration_with_id) }

    before :each do
      MetricConfiguration.expects(:metric_configurations_of).with(metric_configuration.kalibro_configuration_id).returns([metric_configuration])
    end

    it 'should return a pair with the metric configuration code and metric name' do
      expect(helper.native_metrics_of(metric_configuration.kalibro_configuration_id)).to eq [[metric_configuration.metric.code, metric_configuration.metric.name]]
    end
  end

  describe 'supported_metrics_of' do
    let(:metric_collector_details) { FactoryGirl.build(:metric_collector) }

    before :each do
      KalibroClient::Entities::Processor::MetricCollectorDetails.expects(:find_by_name).with(metric_collector_details.name).returns(metric_collector_details)
    end

    it 'should return a list of the supported metrics' do
      expect(helper.supported_metrics_of(metric_collector_details.name)).to eq(metric_collector_details.supported_metrics)
    end
  end

  describe 'choose_metric_path' do
    let(:kalibro_configuration_id) { 1 }

    context 'with a tree metric' do
      let(:metric) { FactoryGirl.build(:loc) }

      it 'is expected to generate the path for MetricConfigurationsController' do
        expect(helper.choose_metric_path(metric, kalibro_configuration_id)).to eq(helper.kalibro_configuration_new_metric_configuration_path(kalibro_configuration_id: kalibro_configuration_id))
      end
    end

    context 'with a hotspot metric' do
      let(:metric) { FactoryGirl.build(:hotspot_metric) }

      it 'is expected to generate the path for HotspotMetricConfigurationsController' do
        expect(helper.choose_metric_path(metric, kalibro_configuration_id)).to eq(helper.kalibro_configuration_hotspot_metric_configurations_path(kalibro_configuration_id: kalibro_configuration_id))
      end
    end
  end

  describe 'hotspot_metric_configuration?' do
    let(:metric_configuration) { FactoryGirl.build(:metric_configuration) }
    let(:hotspot_type) { 'HotspotMetricSnapshot' }
    let(:other_type) { 'NativeMetricSnapshot' }

    it 'is expected to return true for a HotspotMetricSnapshot' do
      metric_configuration.metric.expects(:type).returns(hotspot_type)
      expect(helper.hotspot_metric_configuration?(metric_configuration)).to eq true
    end

    it 'is expected to return false for every other type of metric' do
      metric_configuration.metric.expects(:type).returns(other_type)
      expect(helper.hotspot_metric_configuration?(metric_configuration)).to eq false
    end
  end
end
