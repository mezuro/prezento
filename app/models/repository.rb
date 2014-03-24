class Repository < KalibroGatekeeperClient::Entities::Repository
	include KalibroRecord

  validates :name, presence: true, kalibro_uniqueness: true
  validates :address, presence: true

  def last_processing
    if Processing.has_processing(@id)
      Processing.processing_of(@id)
    else
      nil
    end
  end
end
