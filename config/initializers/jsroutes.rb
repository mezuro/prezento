JsRoutes.setup do |config|
  # This makes sure that routes on JS files follow the root set
  config.prefix = Mezuro::Application.config.relative_url_root
end