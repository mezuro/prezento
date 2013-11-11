require 'json'
class ModulesController < ApplicationController

  # GET /modules/metric_history
  def metric_history
    module_result = ModuleResult.new({ id: params[:module_id] })
    metric_history = module_result.metric_history(params[:metric_name]) # pending: sort this hash.
    dates = Array.new
    values = Array.new
    metric_history.keys.each do |date| 
      dates.push date
      values.push metric_history[date]
    end
    render :json => {dates: dates, values: values}.to_json
  end

end