class MezuroConfigurationOwnership < ActiveRecord::Base
  belongs_to :user
  validates :mezuro_configuration_id, presence: true
end
