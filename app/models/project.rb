class Project < KalibroClient::Entities::Processor::Project
  include KalibroRecord

  attr_writer :attributes

  def self.latest(count = 1)
    all.sort { |a,b| b.id <=> a.id }.select { |project| !project.attributes.hidden}.first(count)
  end

  def attributes
    @project_attributes ||= ProjectAttributes.find_by_project_id(self.id)
    @project_attributes.nil? ? ProjectAttributes.new : @project_attributes
  end

  def destroy
    self.attributes.destroy if self.attributes
    @project_attributes = nil
    super
  end
end
