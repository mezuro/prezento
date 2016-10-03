class Project < KalibroClient::Entities::Processor::Project
  include KalibroRecord
  include HasOwner

  attr_writer :attributes

  def self.latest(count = 1)
    all.sort { |one, another| another.id <=> one.id }.select { |project|
      attributes = project.attributes
      attributes && attributes.public
    }.first(count)
  end

  def attributes
    @attributes ||= ProjectAttributes.find_by_project_id(@id)
  end

  def destroy
    self.attributes.destroy unless self.attributes.nil?
    @attributes = nil
    super
  end
end
