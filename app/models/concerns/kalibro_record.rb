module KalibroRecord
  extend ActiveSupport::Concern

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  delegate :url_helpers, to: 'Rails.application.routes'

  def persisted?
    self.class.exists?(self.id) unless self.id.nil?
  end

  #TODO maybe we don't need this method anymore
  def update(attributes = {})
    self.save
  end

end
