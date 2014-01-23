require "validators/kalibro_uniqueness_validator.rb"

class MezuroConfiguration < KalibroGem::Entities::Configuration
  include KalibroRecord

  attr_accessor :name
  validates :name, presence: true, kalibro_uniqueness: true
end