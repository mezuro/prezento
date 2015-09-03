class Module.Tree
  @load: (loading_html, module_id) ->
    $('div#module_tree').html(loading_html)
    $('div#metric_results').html(loading_html)
    $.post Routes.module_tree_path(module_id)
