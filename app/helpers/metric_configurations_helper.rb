module MetricConfigurationsHelper
  def aggregation_options
    [["Average","AVERAGE"], ["Median", "MEDIAN"], ["Maximum", "MAXIMUM"], ["Minimum", "MINIMUM"],
      ["Count", "COUNT"], ["Standard Deviation", "STANDARD_DEVIATION"]]
  end

  def reading_group_options
    ReadingGroup.all.map { |reading_group| [reading_group.name, reading_group.id] }
  end

  def native_metrics_of(mezuro_configuration_id)
    MetricConfiguration.metric_configurations_of(mezuro_configuration_id).map do |metric_configuration|
      [ metric_configuration.code, metric_configuration.metric.name ]
    end
  end
end

