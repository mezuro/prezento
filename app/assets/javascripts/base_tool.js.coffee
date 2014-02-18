class @BaseTool
 
  # Static Method
  @choose_metric: (mezuro_configuration_id, metric_name, base_tool_name) ->
    $.post '/mezuro_configurations/' + mezuro_configuration_id + '/metric_configurations/new',
          {
            mezuro_configuration_id: mezuro_configuration_id,
            metric_name: metric_name,
            base_tool_name: base_tool_name
          }
