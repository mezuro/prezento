class NameScriptPresenceValidator < ActiveModel::Validator
  def validate(record)
    if record.metric.name.strip.empty?
      record.errors[:name] << "can't be blank"
    end
    if record.metric.script.strip.empty?
      record.errors[:script] << "can't be blank"
    end
  end
end
