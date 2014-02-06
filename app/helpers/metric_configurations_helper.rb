module MetricConfigurationsHelper
  def aggregation_options
    [["Average","AVERAGE"], ["Median", "MEDIAN"], ["Maximum", "MAXIMUM"], ["Minimum", "MINIMUM"],
      ["Count", "COUNT"], ["Standard Deviation", "STANDARD_DEVIATION"]]
  end

  def reading_group_options
    ReadingGroup.all.map { |reading_group| [reading_group.name, reading_group.id] }
  end
end

