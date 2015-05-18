class ReadingGroup < KalibroClient::Entities::Configurations::ReadingGroup
  include KalibroRecord

  def self.public_or_owned_by_user(user=nil)
    query = if user
      ReadingGroupAttributes.where("user_id == ? OR public", user.id)
    else
      ReadingGroupAttributes.where(public: true)
    end

    query.map { |cfg_attr|
      self.find(cfg_attr.reading_group_id)
    }.compact
  end

  def self.public
    self.public_or_owned_by_user
  end

  def attributes
    ReadingGroupAttributes.find_by(reading_group_id: self.id)
  end
end
