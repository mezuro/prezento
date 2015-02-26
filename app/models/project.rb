class Project < KalibroClient::Entities::Processor::Project
  include KalibroRecord
  def self.latest(count = 1)
    all.sort { |a,b| b.id <=> a.id }.select { |project| !project.attributes.hidden}.first(count)
  end

  def attributes
    ProjectAttributes.find_by_project_id(self.id)
  end
end
