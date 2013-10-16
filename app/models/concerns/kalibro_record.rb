module KalibroRecord
  extend ActiveSupport::Concern

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  delegate :url_helpers, to: 'Rails.application.routes'

  def persisted?
    self.class.exists?(self.id) unless self.id.nil? 
  end

  def update(attributes = {})
    attributes.each { |field, value| send("#{field}=", value) if self.class.is_valid?(field) }
    self.save
  end

  def save
    if self.valid? and self.kalibro_errors.empty?
      super
    else
      false
    end
  end
end
