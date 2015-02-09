class Project < KalibroClient::Entities::Processor::Project
  include KalibroRecord
  def self.latest(count = 1)
    all.sort { |a,b| b.id <=> a.id }.first(count)
  end
end
