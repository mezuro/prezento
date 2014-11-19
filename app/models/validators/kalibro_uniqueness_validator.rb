class KalibroUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.class.all.each do |entity|
      if (entity.send(attribute) == value) and (entity.id != record.id)
        record.errors[attribute] << t('kalibro_error_message', :record => t(record.class.name), :attribute => t(attribute.name), :value => value)
        break
      end
    end
  end
end
