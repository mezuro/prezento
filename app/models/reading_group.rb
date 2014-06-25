require "validators/kalibro_uniqueness_validator.rb"

class ReadingGroup < KalibroGatekeeperClient::Entities::ReadingGroup
  include KalibroRecord

  attr_accessor :name
  validates :name, presence: true, kalibro_uniqueness: true

  def readings
    Reading.readings_of(self.id)
  end

  def fork
    params = to_hash.clone
    params.delete(:id)
    params.delete(:errors)
    forked = ReadingGroup.create(params)
    forked
  end
end
