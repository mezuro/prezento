class ModuleResult < KalibroEntities::Entities::ModuleResult
  include KalibroRecord

  def metric_results
    KalibroEntities::Entities::MetricResult.metric_results_of(@id)
  end

  def history_of()
    KalibroEntities::Entities::ModuleResult.history_of(@id).map { |date_module_result| DateModuleResult.new date_module_result.to_hash }
  end
  
  def history_of_grades_of(metric_name)
    history_of_grades = Hash.new

    date_module_result_list = history_of(@id)
    date_module_result_list.each do |date_module_result|
      date_module_result.module_result.metric_results.each do |metric_result|
        if metric_result.metric_configuration_snapshot.metric.name == metric_name then
          metric_grade = metric_result.metric_configuration_snapshot.grade
          break
        end
      end
      history_of_grades[date_module_result.date] = metric_grade
    end
    history_of_grades
  end

end