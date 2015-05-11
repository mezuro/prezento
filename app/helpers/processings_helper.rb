module ProcessingsHelper
  def humanize_eplased_time duration_in_seconds
    distance_of_time_in_words(Time.now, duration_in_seconds.seconds.from_now)
  end

  def format_grade(grade)
    sprintf("%.2f", grade.to_f)
  end

  def find_range_snapshot(metric_result)
    range_snapshots = metric_result.metric_configuration.kalibro_ranges

    range_snapshots.each do |range_snapshot|
      range = Range.new(
        range_snapshot.beginning == '-INF' ? -Float::INFINITY : range_snapshot.beginning.to_f,
        range_snapshot.end == 'INF' ? Float::INFINITY : range_snapshot.end.to_f,
        exclude_end: true
      )
      return range_snapshot if range === metric_result.value
    end

    return nil
  end

  def format_module_name(module_name)
    if module_name.is_a?(Array)
      module_name.last
    elsif module_name.is_a?(String)
      module_name
    else
      module_name.to_s
    end
  end
end
