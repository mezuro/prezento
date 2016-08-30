module RepositoryHelper
  def periodicity_options
    [["Not Periodically", 0], ["1 day", 1], ["2 days", 2], ["Weekly", 7], ["Biweekly", 15], ["Monthly", 30]]
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
    (DateTime.now.year..DateTime.now.year + 5).to_a.map {|year| [year, year]}
  end

  def repository_owner? repository_id
    user_signed_in? && !current_user.repository_attributes.find_by_repository_id(repository_id).nil?
  end
end
