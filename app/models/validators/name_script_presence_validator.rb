class NameScriptPresenceValidator < ActiveModel::Validator
  def validate(record)
    if record.metric.name.empty?
      record.errors[:name] << "can't be blank"
    end
    if record.metric.script.empty?
      record.errors[:script] << "can't be blank"
    end
  end
end
