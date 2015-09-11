module ProcessingsHelper
  def humanize_elapsed_time duration_in_seconds
    distance_of_time_in_words(Time.now, duration_in_seconds.seconds.from_now)
  end

  def format_grade(grade)
    sprintf("%.2f", grade.to_f)
  end

  def find_range_snapshot(metric_result)
    range_snapshots = metric_result.metric_configuration.kalibro_ranges
    range_snapshots.detect { |range_snapshot| range_snapshot.range === metric_result.value }
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
