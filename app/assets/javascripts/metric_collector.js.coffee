class @MetricCollector

  # Static Method
  @choose_metric: (metric_code, metric_collector_name) ->
    $("#metric_code").val(metric_code)
    $("#metric_collector_name").val(metric_collector_name)
    $("form").submit()
