class Project < KalibroEntities::Entities::Project
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  delegate :url_helpers, to: 'Rails.application.routes' 

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
end
