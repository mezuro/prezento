require "validators/code_uniqueness_validator.rb"
require "validators/name_script_presence_validator.rb"

class MetricConfiguration < KalibroGatekeeperClient::Entities::MetricConfiguration
  include KalibroRecord

  attr_accessor :code, :weight, :aggregation_form

  validates :code, presence: true, code_uniqueness: true
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :aggregation_form, presence: true, unless: "metric.compound == true"
  validates_with NameScriptPresenceValidator, unless: "metric.compound == false"

  def mezuro_ranges
    MezuroRange.ranges_of self.id
  end
end
