require 'json'
class ModulesController < ApplicationController

  # GET /modules/metric_history
  def metric_history
    render :json => {mk: "monkey"}.to_json
  end

end