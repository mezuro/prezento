class Module.Tree
  @load: (loading_html, module_id) ->
    $('div#module_tree').html(loading_html)
    $('div#metric_results').html(loading_html)
    $.post '/modules/'+module_id+'/tree'