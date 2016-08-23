class ReadingGroup < KalibroClient::Entities::Configurations::ReadingGroup
  include KalibroRecord
  include HasOwner

  attr_writer :attributes

  def self.public
    self.public_or_owned_by_user
  end

  def attributes
    @attributes ||= ReadingGroupAttributes.find_by(reading_group_id: self.id)
  end

  def destroy
    attributes.destroy unless attributes.nil?
    @attributes = nil
    super
  end
end
