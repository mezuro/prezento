class @BaseTool
 
  # Static Method
  @choose_metric: (metric_name, base_tool_name) ->
    $("#metric_name").val(metric_name)
    $("#base_tool_name").val(base_tool_name)
    $("form").submit()
