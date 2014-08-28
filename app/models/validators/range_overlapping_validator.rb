class RangeOverlappingValidator < ActiveModel::Validator
  def validate(record)
    record.class.ranges_of(record.metric_configuration_id).each do |mezuro_range|
      if mezuro_range.id != record.id && overlaps?(mezuro_range,record)
        record.errors[:beginning] << "There's already a #{record.class} within these boundaries! Please, choose another ones."
        break
      end
    end
  end

  private

  def overlaps?(range1, range2)
    return true if to_float(range1.beginning) >= to_float(range2.beginning) && to_float(range1.beginning) < to_float(range2.end)
    return true if to_float(range1.end) > to_float(range2.beginning) && to_float(range1.end) <= to_float(range2.end)
    return true if to_float(range1.beginning) >= to_float(range2.beginning) && to_float(range1.end) <= to_float(range2.end)
    return true if to_float(range1.beginning) <= to_float(range2.beginning) && to_float(range1.end) >= to_float(range2.end)
    return false
  end

  def to_float(value)
    return 1.0/0 if value=="INF"
    return -1.0/0 if value=="-INF"
    return value
  end
end
