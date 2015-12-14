class @MetricCollector

  # Static Method
  @choose_metric: (metric_code, metric_collector_name, action_path) ->
    $("#metric_code").val(metric_code)
    $("#metric_collector_name").val(metric_collector_name)
    $("form").attr('action', action_path)
    $("form").submit()
