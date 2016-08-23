class KalibroConfiguration < KalibroClient::Entities::Configurations::KalibroConfiguration
  include KalibroRecord
  include HasOwner

  attr_writer :attributes

  def self.public
    self.public_or_owned_by_user
  end

  def self.latest(count = 1)
    all.sort { |one, another| another.id <=> one.id }.select { |kalibro_configuration|
      attributes = kalibro_configuration.attributes
      attributes && attributes.public
    }.first(count)
  end

  def attributes
    @attributes ||= KalibroConfigurationAttributes.find_by(kalibro_configuration_id: self.id)
  end

  def destroy
    attributes.destroy unless attributes.nil?
    @attributes = nil
    super
  end
end
