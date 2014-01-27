class ModulesController < ApplicationController
  #caches_action :metric_history, cache_path: Proc.new{"#{params[:id]}_#{params[:metric_name]}"}, expires_in: 1.day, layout: false

  # POST /modules/1/metric_history
  def metric_history
    module_result = ModuleResult.find(params[:id].to_i)
    @container = params[:container]
    @metric_history = module_result.metric_history(params[:metric_name]) # pending: sort this hash.  
  end

  # POST /modules/1/tree
  def load_module_tree
    @root_module_result = ModuleResult.find(params[:id].to_i)
  end
end