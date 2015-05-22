module KalibroConfigurationsHelper
  def kalibro_configuration_owner?(kalibro_configuration_id)
    user_signed_in? && !current_user.kalibro_configuration_attributes.find_by_kalibro_configuration_id(kalibro_configuration_id).nil?
  end

  def link_to_edit_form(metric_configuration, kalibro_configuration_id)
    if (metric_configuration.metric.is_a? KalibroClient::Entities::Miscellaneous::CompoundMetric)
      link_to(t('edit'), edit_kalibro_configuration_compound_metric_configuration_path(kalibro_configuration_id: kalibro_configuration_id, id: metric_configuration.id), class: 'btn btn-info')
    else
      link_to(t('edit'), edit_kalibro_configuration_metric_configuration_path(kalibro_configuration_id: kalibro_configuration_id, id: metric_configuration.id), class: 'btn btn-info')
    end
  end

  def link_to_show_page(metric_configuration, kalibro_configuration_id)
    if (metric_configuration.metric.is_a? KalibroClient::Entities::Miscellaneous::CompoundMetric)
      link_to(t('show'), kalibro_configuration_compound_metric_configuration_path(kalibro_configuration_id: kalibro_configuration_id, id: metric_configuration.id), class: 'btn btn-info')
    else
      link_to(t('show'), kalibro_configuration_metric_configuration_path(kalibro_configuration_id: kalibro_configuration_id, id: metric_configuration.id), class: 'btn btn-info')
    end
  end
end
