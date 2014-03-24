require "validators/beginning_uniqueness_validator.rb"

class MezuroRange < KalibroGatekeeperClient::Entities::Range
  include KalibroRecord
  
  attr_accessor :beginning, :end, :reading_id, :mezuro_configuration_id, :comments

  validates :beginning, presence: true, beginning_uniqueness: true, numericality: true
  validates :end, presence: true , numericality: true 
  validates :reading_id, presence: true

end
