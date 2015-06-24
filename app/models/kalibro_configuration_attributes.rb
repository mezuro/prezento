class KalibroConfigurationAttributes < ActiveRecord::Base
  belongs_to :user
  validates :kalibro_configuration_id, presence: true
  validates :user, presence: true

  def kalibro_configuration
    @kalibro_configuration ||= KalibroConfiguration.find(kalibro_configuration_id)
  end

  def kalibro_configuration=(cfg)
    @kalibro_configuration = cfg
    self.kalibro_configuration_id = cfg.id
  end
end
