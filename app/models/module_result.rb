class ModuleResult < KalibroEntities::Entities::ModuleResult
  include KalibroRecord

  def metric_results
    KalibroEntities::Entities::MetricResult.metric_results_of(@id)
  end
end