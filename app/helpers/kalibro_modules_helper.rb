module KalibroModulesHelper
  def sort_by_granularity_and_name(module_results)
    module_results.sort! do |a,b|
      if (a.kalibro_module.granularity == b.kalibro_module.granularity)
        a.kalibro_module.name <=> b.kalibro_module.name
      else
        (KalibroClient::Entities::Miscellaneous::Granularity.new(b.kalibro_module.granularity.to_sym) <=> KalibroClient::Entities::Miscellaneous::Granularity.new(a.kalibro_module.granularity.to_sym))
      end
    end
  end
end