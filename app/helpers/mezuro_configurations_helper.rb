module MezuroConfigurationsHelper
  def configuration_owner?(configuration_id)
    user_signed_in? && !current_user.mezuro_configuration_ownerships.find_by_mezuro_configuration_id(configuration_id).nil?
  end
end