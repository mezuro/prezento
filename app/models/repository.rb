class Repository < KalibroClient::Entities::Processor::Repository
  include KalibroRecord

  def self.latest(count=1)
    all.sort { |one, another| another.id <=> one.id }.first(count)
  end
end
