class KalibroUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.class.all.each do |entity|
      if entity.send(attribute) == value
        record.kalibro_errors << "There's already a #{record.class} with this #{attribute}! Please, choose another one."
      end
    end
  end
end
