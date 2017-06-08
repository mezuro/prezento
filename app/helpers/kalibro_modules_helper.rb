module KalibroModulesHelper
  # The comparison between FUNCTION and CLASS or METHOD does not make sense for kalibro.
  # Still, we want to sort the kalibro modules to present it to the user.
  # So, we define that FUNCTION are smaller than all the other granularities.
  class ComparableGranularity < KalibroClient::Entities::Miscellaneous::Granularity
    def <=>(other)
      response = super(other)
      if response.nil?
        response = self.type == :FUNCTION ? -1 : 1
      end
      response
    end
  end

  def sort_by_granularity_and_name(module_results)
    module_results.sort! do |results_first, results_second|
      module_first = results_first.kalibro_module
      module_second = results_second.kalibro_module
      if (module_first.granularity == module_second.granularity)
        module_first.name <=> module_second.name
      else
        compare_type_granularity(module_first, module_second)
      end
    end
  end

  def compare_type_granularity(module_first, module_second)
    comparable_type_first = ComparableGranularity.new(module_second.granularity.type)
    comparable_type_second = ComparableGranularity.new(module_first.granularity.type)
    (comparable_type_first <=> comparable_type_second)
  end
end
