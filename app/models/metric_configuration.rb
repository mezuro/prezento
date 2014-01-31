class MetricConfiguration < KalibroGem::Entities::MetricConfiguration
  include KalibroRecord

  attr_accessor :code, :weight, :aggregation_form, :metric_name, :metric_scope, :metric_origin

  validates :code, presence: true, kalibro_uniqueness: true
  validates :weight, presence: true
  validates :aggregation_form, presence: true
  validates :metric_name, presence: true
  validates :metric_scope, presence: true
  validates :metric_origin, presence: true

end
