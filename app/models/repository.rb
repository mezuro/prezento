class Repository < KalibroClient::Entities::Processor::Repository
  include KalibroRecord
  include HasOwner

  attr_writer :attributes

  def self.latest(count=1)
    all.sort { |one, another| another.id <=> one.id }.select { |repository| repository.attributes.public }.first(count)
  end

  def attributes
    @attributes ||= RepositoryAttributes.find_by_repository_id(@id)
  end

  def destroy
    self.attributes.destroy unless self.attributes.nil?
    @attributes = nil
    super
  end
end
