class Repository.Branch
  constructor: ->
    @names = {}
    @request = null

  toggle: ->
    if $("#repository_scm_type").val() != "SVN"
      $("#branches").show()
      @fetch($("#repository_address").val())
    else
      $("#branches").hide()

  cancel_request: ->
    if @request != null
      @request.abort()
      @request = null

  fill_options: (options, el) ->
    # FIXME: this works only if master is the default branch
    #        it can be improved by moving it into KalibroProcessor
    default_branch = "master"
    if default_branch in options
      # Brings the default branch as the first option
      index = options.indexOf(default_branch)
      options.splice(index, 1)
      options.unshift(default_branch)
    for option in options
      do ->
        el.append($("<option></option>")
          .attr("value", option)
          .text(option))

  fetch: (address) ->
    @cancel_request()

    # Prevent a call with blank address
    if address == ""
      return

    el = $("#repository_branch")
    el.empty() # remove old options

    if @names[address]?
      @fill_options(@names[address], el)
      return

    scm_type = $("#repository_scm_type").val()

    context = this
    @request = $.get '/repository_branches',
      {'url': address, 'scm_type': scm_type},
      (data) ->
        unless data["errors"]
          options = data["branches"]
          if options != null
            context.names[address] = options
            context.fill_options(options, el)
