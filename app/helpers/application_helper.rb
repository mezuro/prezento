module ApplicationHelper
  def t_hint(attribute_key, class_key=nil)
    class_key ||= controller_name.singularize
    t("activemodel.hints.#{class_key}.#{attribute_key}")
  end
end
