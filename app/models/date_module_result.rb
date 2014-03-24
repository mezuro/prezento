class DateModuleResult < KalibroGatekeeperClient::Entities::DateModuleResult
  include KalibroRecord

  def module_result
    ModuleResult.new @module_result.to_hash
  end

end