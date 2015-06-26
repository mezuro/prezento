if defined?(Konacha)
  Konacha.configure do |config|
    require 'capybara/poltergeist'

    config.spec_dir     = "spec/javascripts"
    config.spec_matcher = /_spec\.|_test\./
    config.stylesheets  = %w(application)
    config.driver = :poltergeist
  end

  # Use thin to run Konacha tests. This is needed because the tests hang frequently in Travis using the default (WEBRick)
  # We can't just do 'Capybara.server' in the configure block because it will also apply to anything else run by
  # Capybara. So instead, override the Konacha.run method to change the server, and restore it after completion.
  module Konacha
    class << self
      old_run = instance_method(:run)

      define_method(:run) do
        prev_server = Capybara.server
        begin
          Capybara.server do |app, port|
            require 'rack/handler/thin'
            Rack::Handler::Thin.run(app, :Port => port)
          end
          old_run.bind(self).call
        ensure
          Capybara.server(&prev_server)
        end
      end
    end
  end
end
