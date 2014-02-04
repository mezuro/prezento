class CodeUniquenessValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.class.metric_configurations_of(record.configuration_id).each do |metric_configuration|
      if metric_configuration.code == value && metric_configuration.id != record.id
        record.errors[attribute] << "There's already a #{record.class} with #{attribute} #{value}! Please, choose another one."
        break
      end
    end
  end
end