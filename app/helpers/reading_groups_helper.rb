module ReadingGroupsHelper
  def reading_groups_owner? reading_group_id
    user_signed_in? && !current_user.reading_group_attributes.find_by_reading_group_id(reading_group_id).nil?
  end
end