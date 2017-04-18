# Monkey Patch for Rack to choose Puma as the default webserver. 
# Without this, Thin takes precedence over Puma.
# Removing Thin would make this unnecessary. However, Thin is needed for Konacha.

module Rack
  require 'rack/handler/puma'

  module Handler

    def self.default argument
      return Rack::Handler::Puma
    end

  end
end