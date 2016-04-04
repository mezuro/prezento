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

AfterConfiguration do |config|
  KalibroClient::KalibroCucumberHelpers.clean_configurations
  KalibroClient::KalibroCucumberHelpers.clean_processor
end

Around('@enable_forgery_protection') do |scenario, block|
  old_value = ActionController::Base.allow_forgery_protection
  begin
    ActionController::Base.allow_forgery_protection = true
    block.call
  ensure
    ActionController::Base.allow_forgery_protection = old_value
  end
end
