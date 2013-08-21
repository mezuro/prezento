require "validators/kalibro_uniqueness_validator.rb"

class Project < KalibroEntities::Entities::Project
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  delegate :url_helpers, to: 'Rails.application.routes' 

  attr_accessor :name
  validates :name, presence: true, kalibro_uniqueness: true

  def persisted?
    Project.exists?(self.id) unless self.id.nil? 
  end

  def update(attributes = {})
    attributes.each { |field, value| send("#{field}=", value) if self.class.is_valid?(field) }
    self.save
  end

  def self.latest(count = 1)
    all.sort { |a,b| b.id <=> a.id }.first(count)
  end

  def save
    if (self.valid? and self.kalibro_errors.nil?) 
      super.save
    else
      false
    end
  end
end
