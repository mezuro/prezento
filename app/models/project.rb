class Project < KalibroEntities::Entities::Project
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  delegate :url_helpers, to: 'Rails.application.routes' 

  def persisted?
    false
  end
end
