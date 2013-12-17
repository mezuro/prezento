require "validators/kalibro_uniqueness_validator.rb"

class ReadingGroup < KalibroGem::Entities::ReadingGroup
  include KalibroRecord

  attr_accessor :name
  validates :name, presence: true, kalibro_uniqueness: true

  def readings
    Reading.readings_of(self.id)
  end
end
