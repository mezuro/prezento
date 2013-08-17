class Project < KalibroEntities::Entities::Project
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  delegate :url_helpers, to: 'Rails.application.routes' 

  def persisted?
    false
  end

  def self.latest(count = 1)
    all.sort { |a,b| b.id <=> a.id }.first(count)
  end
end
