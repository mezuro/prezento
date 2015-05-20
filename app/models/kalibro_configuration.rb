class KalibroConfiguration < KalibroClient::Entities::Configurations::KalibroConfiguration
  include KalibroRecord

  def self.public_or_owned_by_user(user=nil)
    kalibro_configuration_attributes = KalibroConfigurationAttributes.where(public: true)
    kalibro_configuration_attributes += KalibroConfigurationAttributes.where(user_id: user.id, public: false) if user

    kalibro_configuration_attributes.map { |kalibro_configuration_attribute|
      begin
        self.find(kalibro_configuration_attribute.kalibro_configuration_id)
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
