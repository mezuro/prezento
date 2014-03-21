class Reading < KalibroGatekeeperClient::Entities::Reading
	include KalibroRecord
  
  attr_accessor :label, :grade, :color

  validates :label, presence: true, kalibro_uniqueness: true
  validates :grade, presence: true, numericality: true
  validates :color, presence: true

end
