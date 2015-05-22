class ChangeReadingGroupAttributesPublicDefault < ActiveRecord::Migration
  def up
    change_column_default :reading_group_attributes, :public, true
  end

  def down
    change_column_default :reading_group_attributes, :public, false
  end
end
