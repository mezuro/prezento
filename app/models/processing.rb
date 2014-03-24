class Processing < KalibroGatekeeperClient::Entities::Processing
  include KalibroRecord

  def ready?
    @state == "READY"
  end

  def root_module_result
    ModuleResult.find(@results_root_id)
  end
end
