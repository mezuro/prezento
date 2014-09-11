class @BaseTool

  # Static Method
  @choose_metric: (metric_name, metric_collector_name) ->
    $("#metric_name").val(metric_name)
    $("#metric_collector_name").val(metric_collector_name)
    $("form").submit()
