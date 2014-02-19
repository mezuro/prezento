module MezuroConfigurationsHelper
  def mezuro_configuration_owner?(mezuro_configuration_id)
    user_signed_in? && !current_user.mezuro_configuration_ownerships.find_by_mezuro_configuration_id(mezuro_configuration_id).nil?
  end

  def link_to_edit_form(metric_configuration, mezuro_configuration_id)
    if (metric_configuration.metric.compound)
      link_to('Edit', edit_mezuro_configuration_compound_metric_configuration_path(mezuro_configuration_id, metric_configuration.id), class: 'btn btn-info')
    else
      link_to('Edit', edit_mezuro_configuration_metric_configuration_path(mezuro_configuration_id, metric_configuration.id), class: 'btn btn-info')
    end
  end

  def link_to_show_page(metric_configuration, mezuro_configuration_id)
    if (metric_configuration.metric.compound)
      link_to('Show', mezuro_configuration_compound_metric_configuration_path(mezuro_configuration_id, metric_configuration.id), class: 'btn btn-info')
    else
      link_to('Show', mezuro_configuration_metric_configuration_path(mezuro_configuration_id, metric_configuration.id), class: 'btn btn-info')
    end
  end
end
