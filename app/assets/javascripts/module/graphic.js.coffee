@Module = { }

class Module.Graphic
  constructor: (@container, @metric_name, @module_id) ->
    $('tr#'+@container).slideDown('slow')
    this.load()

  load: ->
    # Those two var are necessary so the jQuery callback can use them
    # Otherwise the scope of the callback function is isolated
    container = @container 
    display = this.display

    $.get '/modules/metric_history',
          metric_name: @metric_name
          module_id: @module_id
          (data) ->
            display(data,container)

  display: (data, container) ->
    $('div#'+container).html('<img src="data:image/png;base64,' + data + '" />')
