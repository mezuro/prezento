class KalibroConfiguration < KalibroClient::Entities::Configurations::KalibroConfiguration
  include KalibroRecord

  def self.public_or_owned_by_user(user=nil)
    query = if user
      KalibroConfigurationAttributes.where("user_id == ? OR public", user.id)
    else
      KalibroConfigurationAttributes.where(public: true)
    end

    query.map { |cfg_attr|
      begin
        self.find(cfg_attr.kalibro_configuration_id)
      rescue KalibroClient::Errors::RecordNotFound
        nil
      end
    }.compact
  end

  def self.public
    self.public_or_owned_by_user
  end

  def attributes
    KalibroConfigurationAttributes.find_by(kalibro_configuration_id: self.id)
  end

  def destroy
    attrs = attributes
    attrs.destroy unless attrs.nil?
    super
  end
end
