class Repository < KalibroClient::Entities::Processor::Repository
  include KalibroRecord

  attr_writer :attributes

  def self.public_or_owned_by_user(user = nil)
    repository_attributes = RepositoryAttributes.where(public: true)
    repository_attributes += RepositoryAttributes.where(user_id: user.id, public: false) if user

    repository_attributes.map do |attribute|
      begin
        self.find(attribute.repository_id)
      rescue Likeno::Errors::RecordNotFound
        nil
      end
    end.compact
  end

  def self.latest(count=1)
    all.sort { |one, another| another.id <=> one.id }.first(count)
  end

  def attributes
    @attributes ||= RepositoryAttributes.find_by_repository_id(@id)
  end
end
