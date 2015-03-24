module CompoundMetricConfigurationsHelper
  def scope_options
    [[t("scopes.METHOD"),"METHOD"], [t("scopes.CLASS"), "CLASS"], [t("scopes.PACKAGE"), "PACKAGE"], [t("scopes.SOFTWARE"), "SOFTWARE"]]
  end
end
