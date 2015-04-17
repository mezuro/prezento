module ApplicationHelper
  def t_hint(attribute_key, class_key=nil, options={})
    class_key ||= controller_name.singularize
    t("activemodel.hints.#{class_key}.#{attribute_key}", options)
  end
end
