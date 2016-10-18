class Project < KalibroClient::Entities::Processor::Project
  include KalibroRecord
  include HasOwner

  attr_writer :attributes

  def attributes
    @attributes ||= ProjectAttributes.find_by_project_id(@id)
  end

  def destroy
    self.attributes.destroy unless self.attributes.nil?
    @attributes = nil
    super
  end
end
