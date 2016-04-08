module CompoundMetricConfigurationsHelper
  def scope_options
    %w(FUNCTION METHOD CLASS PACKAGE SOFTWARE).map do |scope|
      [t("scopes.#{scope}"), scope]
    end
  end

  def compound_metric_human_name(count=1)
    key = count > 1 ? 'other': 'one'
    t("activemodel.models.compound_metric_configuration.#{key}")
  end

  def compound_metric_human_attribute_name(attribute_key)
    t("activemodel.attributes.compound_metric_configuration.#{attribute_key}")
  end
end
