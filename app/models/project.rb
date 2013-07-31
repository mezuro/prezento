class Project < KalibroEntities::Entities::Project
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name

  def persisted?
    false
  end
end
