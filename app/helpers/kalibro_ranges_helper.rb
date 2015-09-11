module KalibroRangesHelper
  def readings_options(readings)
    readings.map { |reading| [reading.label, reading.id] }
  end

  # FIXME: this is a workaround while kalibro_client does not handle Infinity text instead of INF
  #        see: https://github.com/mezuro/kalibro_client/issues/73
  def format_boundary(value)
    return "INF" if value == Float::INFINITY
    return "-INF" if value == -Float::INFINITY
    value
  end
end
