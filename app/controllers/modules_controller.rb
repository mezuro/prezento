include ResourceFinder

class ModulesController < ApplicationController
  # POST /modules/1/metric_history
  def metric_history
    @module_result = find_resource(ModuleResult, params[:id].to_i)
    @container = params[:container]
    @metric_name = params[:metric_name]
  end

  # POST /modules/1/tree
  def load_module_tree
    @root_module_result = find_resource(ModuleResult, params[:id].to_i)
  end
end