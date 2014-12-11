class KalibroConfigurationOwnership < ActiveRecord::Base
  belongs_to :user
  validates :kalibro_configuration_id, presence: true
end
