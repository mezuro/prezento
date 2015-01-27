module KalibroRangesHelper
	def readings_options(readings)
		readings.map { |reading| [reading.label, reading.id] }
	end
end