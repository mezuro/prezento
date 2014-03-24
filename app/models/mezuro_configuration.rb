require "validators/kalibro_uniqueness_validator.rb"

class MezuroConfiguration < KalibroGatekeeperClient::Entities::Configuration
  include KalibroRecord

  attr_accessor :name
  validates :name, presence: true, kalibro_uniqueness: true

  def metric_configurations
    MetricConfiguration.metric_configurations_of(self.id)
  end
end
