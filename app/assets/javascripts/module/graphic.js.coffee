class Module.Graphic
  constructor: (@container, @metric_name, @module_id) ->
    $('tr#'+@container).slideToggle('slow')
    this.load()

  load: ->
    $.post '/modules/' + @module_id + '/metric_history',
          {
            metric_name: @metric_name,
            container: @container
          }

  @display: (dates, values, container) ->
    opts = {bezierCurve: false}

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

    graphic = new Chart($('canvas#'+container).get(0).getContext("2d")).Line(data, opts)
