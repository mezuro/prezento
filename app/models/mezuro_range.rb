require "validators/beginning_uniqueness_validator.rb"

class MezuroRange < KalibroGatekeeperClient::Entities::Range
  include KalibroRecord

  attr_accessor :beginning, :end, :reading_id, :mezuro_configuration_id, :comments

  validates :beginning, presence: true, beginning_uniqueness: true
  validates :beginning, numericality: true, if: :non_infinite_beginning?
  validates :end, presence: true
  validates :end, numericality: true, if: :non_infinite_end?
  validates :reading_id, presence: true

  private

  def non_infinite_end?
    !(self.end == '-INF' || self.end == 'INF')
  end

  def non_infinite_beginning?
    val = !(self.beginning == '-INF' || self.beginning == 'INF')
  end
end
