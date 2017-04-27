require 'rails_helper'
require "#{Rails.root}/lib/core_extensions/rack/handler"

RSpec.describe Rack::Handler do

    describe 'default webserver' do
        it 'should be puma' do
            argument = 'argument'
            expect(Rack::Handler.default argument).to eq(Rack::Handler::Puma)
        end
    end
end