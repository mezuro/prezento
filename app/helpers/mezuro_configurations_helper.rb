module MezuroConfigurationsHelper
  def mezuro_configuration_owner?(mezuro_configuration_id)
    user_signed_in? && !current_user.mezuro_configuration_ownerships.find_by_mezuro_configuration_id(mezuro_configuration_id).nil?
  end
end