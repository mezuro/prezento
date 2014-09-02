class GreaterThanBeginningValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if record.beginning.is_a?(String) || value.is_a?(String) #TODO This will be useless when we start representing INF as ruby Infinity with the new Kalibro configuration application.
      if record.beginning=="INF" || value=="-INF" || record.beginning == value
        add_error(record,attribute)
      end
    elsif record.beginning >= value
      add_error(record,attribute)
    end
  end

  private

  def add_error(record, attribute)
    record.errors[attribute] << "The End value should be greater than the Beginning value."
  end

end
