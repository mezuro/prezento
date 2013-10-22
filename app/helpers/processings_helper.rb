module ProcessingsHelper
  def humanize_eplased_time duration_in_milliseconds
    distance_of_time_in_words(Time.now, (duration_in_milliseconds/1000.0).seconds.from_now)
  end
end