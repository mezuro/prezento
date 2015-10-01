class ModuleResult < KalibroClient::Entities::Processor::ModuleResult
  def metric_history(name)
    history = KalibroClient::Entities::Processor::TreeMetricResult.history_of(name, self.id, processing.repository_id)
    grade_history = Hash.new

    history.each { |date_metric_result| grade_history[date_metric_result.date] = date_metric_result.metric_result.value }

    grade_history
  end
end
