class ReadingGroup < KalibroClient::Entities::Configurations::ReadingGroup
  include KalibroRecord

  def self.public_or_owned_by_user(user=nil)
    query = if user
      ReadingGroupAttributes.where("user_id == ? OR public", user.id)
    else
      ReadingGroupAttributes.where(public: true)
    end

    query.map { |rg_attr|
      begin
        self.find(rg_attr.reading_group_id)
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
