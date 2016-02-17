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
    module_results.sort! do |a,b|
      if (a.kalibro_module.granularity == b.kalibro_module.granularity)
        a.kalibro_module.name <=> b.kalibro_module.name
      else
        (ComparableGranularity.new(b.kalibro_module.granularity.type) <=> ComparableGranularity.new(a.kalibro_module.granularity.type))
      end
    end
  end
end