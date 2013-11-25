module ProcessingsHelper
  def humanize_eplased_time duration_in_milliseconds
    distance_of_time_in_words(Time.now, (duration_in_milliseconds/1000.0).seconds.from_now)
  end

  def format_grade(grade)
    sprintf("%.2f", grade.to_f)
  end

  def find_range_snapshot(metric_result)
    range_snapshots = metric_result.metric_configuration_snapshot.range_snapshot

    range_snapshots.each do |range_snapshot|
      return range_snapshot if ((range_snapshot.beginning <= metric_result.value || range_snapshot.beginning == '-INF') && (range_snapshot.end >= metric_result.value || range_snapshot.beginning == '+INF'))
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