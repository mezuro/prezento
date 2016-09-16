module RepositoryHelper
  def periodicity_options
    [[t('not_periodically'), 0], [t('one_day'), 1], [t('two_days'), 2], [t('weekly'), 7], [t('biweekly'), 15], [t('monthly'), 30]]
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
    # FIXME: this will not work some years from now
    (2013..2020).to_a.map {|year| [year, year]}
  end

  def repository_owner? repository_id
    user_signed_in? && !current_user.repository_attributes.find_by_repository_id(repository_id).nil?
  end
end
