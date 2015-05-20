class ReadingGroup < KalibroClient::Entities::Configurations::ReadingGroup
  include KalibroRecord

  def self.public_or_owned_by_user(user=nil)
    reading_group_attributes = ReadingGroupAttributes.where(public: true)
    reading_group_attributes += ReadingGroupAttributes.where(user_id: user.id, public: false) if user

    reading_group_attributes.map { |reading_group_attribute|
      begin
        self.find(reading_group_attribute.reading_group_id)
      rescue KalibroClient::Errors::RecordNotFound
        nil
      end
    }.compact
  end

  def self.public
    self.public_or_owned_by_user
  end

  def attributes
    ReadingGroupAttributes.find_by(reading_group_id: self.id)
  end
end
