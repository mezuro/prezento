class ModuleResult < KalibroEntities::Entities::ModuleResult
  include KalibroRecord

  def metric_results
    KalibroEntities::Entities::MetricResult.metric_results_of(@id)
  end

  def history
    self.class.history_of(@id).map { |date_module_result| DateModuleResult.new date_module_result.to_hash }
  end
  
  def metric_history(name)
    grade_history = Hash.new

    history.each { |date_module_result| grade_history[date_module_result.date] =
                    find_grade_by_metric_name(date_module_result.module_result.metric_results, name) }

    grade_history
  end

  private

  def find_grade_by_metric_name(metric_results, name)
    metric_results.each { |metric_result| return metric_result.value if metric_result.metric_configuration_snapshot.metric.name == name }
  end
end