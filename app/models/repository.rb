class Repository < KalibroGem::Entities::Repository
	include KalibroRecord

  validates :name, presence: true, kalibro_uniqueness: true
  validates :address, presence: true

  def last_processing
    Processing.processing_of(@id)
  end
end
