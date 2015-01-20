class ModuleResult < KalibroClient::Entities::Processor::ModuleResult

  def metric_history(name)
    history = self.processing.repository.module_result_history_of(self)
    grade_history = Hash.new

    history.each { |date_module_result| grade_history[date_module_result.date] =
                    find_grade_by_metric_name(date_module_result.module_result.metric_results, name) }

    grade_history
  end

  private

  def find_grade_by_metric_name(metric_results, name)
    metric_results.each { |metric_result| return metric_result.value if metric_result.metric_configuration.metric_snapshot.name == name }
  end
end
