After do |scenario|
  # Do something after each scenario.
  # The +scenario+ argument is optional, but
  # if you use it, you can inspect status with
  # the #failed?, #passed? and #exception methods.
  Rails.cache.clear
end

# Run all acceptance tests on the default language
Before do |scenario|
  if defined?(page) && ! page.driver.nil?
    header_method = [:add_header, :header].find(&page.driver.method(:respond_to?))
    page.driver.send(header_method, 'Accept-Language', I18n.default_locale) if header_method
  end

  I18n.locale = I18n.default_locale
end
