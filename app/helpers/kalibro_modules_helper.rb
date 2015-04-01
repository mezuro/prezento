module KalibroModulesHelper
  def sort_by_granularity_and_name(module_results)
    module_results.sort do |a,b|
      (a.kalibro_module.granularity == b.kalibro_module.granularity) ? a.kalibro_module.name <=> b.kalibro_module.name : -a.kalibro_module.granularity.length <=> -b.kalibro_module.granularity.length
    end
  end
end