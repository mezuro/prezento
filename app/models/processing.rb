class Processing < KalibroEntities::Entities::Processing
  include KalibroRecord

  def ready?
    @state == "READY"
  end

  def metric_results
    KalibroEntities::Entities::MetricResult.metric_results_of(@results_root_id)
  end

  def root_module_result
    KalibroEntities::Entities::ModuleResult.find(@results_root_id)
  end
end
