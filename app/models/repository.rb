class Repository < KalibroClient::Entities::Processor::Repository
  def last_processing_of
    if has_processing
      last_processing
    else
      nil
    end
  end
end
