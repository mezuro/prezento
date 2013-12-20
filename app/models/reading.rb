class Reading < KalibroGem::Entities::Reading
	include KalibroRecord

  validates :color, presence: true
  validates :label, presence: true, kalibro_uniqueness: true

end
