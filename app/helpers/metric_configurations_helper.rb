module MetricConfigurationsHelper
  def aggregation_options
    [[t("aggregation_forms.AVERAGE"),"AVERAGE"], [t("aggregation_forms.MEDIAN"), "MEDIAN"], [t("aggregation_forms.MAXIMUM"), "MAXIMUM"], [t("aggregation_forms.MINIMUM"), "MINIMUM"], [t("aggregation_forms.STANDARD_DEVIATION"), "STANDARD_DEVIATION"], [t("aggregation_forms.COUNT"), "COUNT"]]
  end

  def reading_group_options
    ReadingGroup.all.map { |reading_group| [reading_group.name, reading_group.id] }
  end

  def native_metrics_of(kalibro_configuration_id)
    MetricConfiguration.metric_configurations_of(kalibro_configuration_id).map do |metric_configuration|
      [ metric_configuration.metric.code, metric_configuration.metric.name ]
    end
  end

  def supported_metrics_of(metric_collector_name)
    KalibroClient::Entities::Processor::MetricCollectorDetails.find_by_name(metric_collector_name).supported_metrics
  end
end
