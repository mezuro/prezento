class Repository < KalibroClient::Entities::Processor::Repository
  include KalibroRecord
  include HasOwner

  attr_writer :attributes

  def attributes
    @attributes ||= RepositoryAttributes.find_by_repository_id(@id)
  end

  def destroy
    self.attributes.destroy unless self.attributes.nil?
    @attributes = nil
    super
  end
end
