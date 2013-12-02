class Module.Repository
  constructor: (@project_id, @repository_id) ->

  poll_state: (last_state) ->
    $.post '/projects/' + @project_id + '/repositories/' + @repository_id + '/state',
          last_state: last_state

  schedule_poll_state: (last_state) ->
    context = this
    call = () ->
              context.poll_state(last_state)

    setTimeout( call, 15000 ) # Delays in 15s the next call
