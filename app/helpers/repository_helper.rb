module RepositoryHelper
  def periodicity_options
    [[t("periodicity.NOT_PERIODICALLY"), 0], [t("periodicity.1_DAY"), 1], [t("periodicity.2_DAYS"), 2], [t("periodicity.WEEKLY"), 7], [t("periodicity.BIWEEKLY"), 15], [t("periodicity.MONTHLY"), 30]]
  end

  def license_options
   YAML.load_file("config/licenses.yml").split("; ")
  end

  def periodicity_option(periodicity)
    periodicity_label = periodicity_options.select {|option| option.last == periodicity}.first
    unless periodicity_label.nil?
      return periodicity_label.first
    end
  end

  def day_options
    (1..31).to_a.map {|day| [day, day]}
  end

  def month_options
    (1..12).to_a.map {|month| [month, month]}
  end

  def year_options
    (2013..2020).to_a.map {|year| [year, year]}
  end
end
