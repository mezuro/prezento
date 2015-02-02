module KalibroRecord
  extend ActiveSupport::Concern

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  delegate :url_helpers, to: 'Rails.application.routes'
end
