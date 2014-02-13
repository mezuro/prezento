require "validators/beginning_uniqueness_validator.rb"

class MezuroRange < KalibroGem::Entities::Range
  include KalibroRecord
  
  attr_accessor :beginning, :end, :reading_id, :metric_configuration_id, :mezuro_configuration_id, :comments

  validates :beginning, presence: true, beginning_uniqueness: true
  validates :end, presence: true #TODO: Validates numeracy
  validates :reading_id, presence: true

end