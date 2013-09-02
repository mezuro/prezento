class KalibroUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.class.all.each do |entity|
      if (entity.send(attribute) == value) and (entity.id != record.id)
        record.errors[attribute] << "There's already a #{record.class} with #{attribute} #{value}! Please, choose another one."
        break
      end
    end
  end
end
