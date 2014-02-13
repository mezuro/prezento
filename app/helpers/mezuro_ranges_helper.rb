module MezuroRangesHelper

	def readings_options(reading_group)
		reading_group.readings.map { |reading| [reading.label, reading.id] }
	end
end