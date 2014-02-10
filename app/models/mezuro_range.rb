class MezuroRange < KalibroGem::Entities::Range
  include KalibroRecord
  
  attr_accessor :beginning, :end, :reading_id, :metric_configuration_id

  validates :beginning, presence: true, beginning_uniqueness: true
  validates :end, presence: true #TODO: Validates numeracy

end