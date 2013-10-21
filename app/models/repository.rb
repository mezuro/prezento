class Repository < KalibroEntities::Entities::Repository
	include KalibroRecord

  def last_processing
    Processing.processing_of(@id)
  end
end
