class KalibroUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.class.all.each do |entity|
      if (entity.send(attribute) == value) and (entity.id != record.id)
        record.errors[attribute] << "There is already a #{record.class} with #{attribute} #{value}! Please, choose another one." #I18n.t('kalibro_error_message', :record => t(record.class.name), :attribute => t(attribute.name), :value => value)
        break
      end
    end
  end
end
