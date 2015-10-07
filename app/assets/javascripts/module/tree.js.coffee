class Module.Tree
  @load: (loading_html, module_id) ->
    # FIXME: The messages we send on loading_html are the same already
    # shown on the Repository's show page
    $('div#module_tree').html(loading_html)
    $('div#metric_results').html(loading_html)
    $('div#hotspot_metric_results').html(loading_html)
    $.post Routes.module_tree_path(module_id)
