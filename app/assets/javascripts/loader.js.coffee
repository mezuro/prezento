$(document).on 'page:fetch', ->
  $('#loader').fadeIn 'slow'

$(document).on 'page:restore', ->
  $('#loader').fadeOut 'slow'