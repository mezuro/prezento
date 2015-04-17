module CompoundMetricConfigurationsHelper
  def scope_options
    [[t("scopes.METHOD"),"METHOD"], [t("scopes.CLASS"), "CLASS"], [t("scopes.PACKAGE"), "PACKAGE"], [t("scopes.SOFTWARE"), "SOFTWARE"]]
  end

  def compound_metric_human_name(count=1)
    key = count > 1 ? 'other': 'one'
    t("activemodel.models.compound_metric_configuration.#{key}")
  end

  def compound_metric_human_attribute_name(attribute_key)
    t("activemodel.attributes.compound_metric_configuration.#{attribute_key}")
  end
end
