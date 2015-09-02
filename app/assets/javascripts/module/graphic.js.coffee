class Module.Graphic
  constructor: (@container, @metric_name, @module_id) ->
    drawer = $('tr#'+@container)
    if drawer.is(":hidden")
      drawer.slideDown('slow')
      this.load()
    else
      drawer.slideUp('slow')

  load: ->
    $.post Routes.module_metric_history_path(@module_id),
          {
            metric_name: @metric_name,
            container: @container
          }

  @display: (dates, values, container) ->
    canvas = $('canvas#'+container).get(0)

    opts = {
      bezierCurve: false,
      responsive: true,
      maintainAspectRatio: false
    }

    data = {
      labels : dates,
      datasets : [
        {
          fillColor : "rgba(220,220,220,0.5)",
          strokeColor : "rgba(220,220,220,1)",
          pointColor : "rgba(220,220,220,1)",
          pointStrokeColor : "#000",
          data : values
        }
      ]
    }

    if canvas.hasOwnProperty("chart") && canvas.chart != null
      canvas.chart.destroy()
      canvas.chart = null

    canvas.chart = new Chart(canvas.getContext("2d")).Line(data, opts)
