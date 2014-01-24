class MezuroConfigurationOwnership < ActiveRecord::Base
  belongs_to :user
  validates :mezuro_configuration_id, presence: true

  def mezuro_configuration
    MezuroConfiguration.find(mezuro_configuration_id)
  end
end
