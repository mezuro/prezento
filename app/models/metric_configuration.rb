require "validators/code_uniqueness_validator.rb"

class MetricConfiguration < KalibroGatekeeperClient::Entities::MetricConfiguration
  include KalibroRecord

  attr_accessor :code, :weight, :aggregation_form

  validates :code, presence: true, code_uniqueness: true
  validates :weight, presence: true
  validates :aggregation_form, presence: true

  def mezuro_ranges
    MezuroRange.ranges_of self.id
  end
end
