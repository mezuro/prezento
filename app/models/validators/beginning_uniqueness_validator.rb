class BeginningUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.class.ranges_of(record.metric_configuration_id).each do |mezuro_range|
      if mezuro_range.beginning == value && mezuro_range.id != record.id
        record.errors[attribute] << "There's already a #{record.class} with #{attribute} #{value}! Please, choose another one."
        break
      end
    end
  end
end