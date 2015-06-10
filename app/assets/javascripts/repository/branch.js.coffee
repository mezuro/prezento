class Repository.Branch
  constructor: ->
    @names = {}
    @request = null

  toggle: ->
    scm_type_field = document.getElementById("repository_scm_type")
    index = scm_type_field.selectedIndex
    option = scm_type_field.options[index]

    if option.value != "SVN"
      $("#branches").show()
      @fetch_branches(document.getElementById("repository_address"))
    else
      $("#branches").hide()

  cancel_request: ->
    if @request != null
      @request.abort()
      @request = null

  # private method
  #fill_options = (options, el) ->
  fill_options: (options, el) ->
    for option in options
      do ->
        el.append($("<option></option>")
          .attr("value", option)
          .text(option))

  fetch_branches: (address_field) ->
    @cancel_request()
    address = address_field.value

    # Prevent a call with blank address
    if address == ""
      return

    el = $("#repository_branch")
    el.empty() # remove old options

    if @names[address]?
      @fill_options(@names[address], el)
      return

    scm_type = $("#repository_scm_type option:selected").text()

    context = this
    @request = $.get '/repository_branches',
      {'url': address, 'scm_type': scm_type},
      (data) ->
        options = data["branches"]
        if options != null
          context.names[address] = options
          context.fill_options(options, el)
