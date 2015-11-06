class ChangeProjectAttributesPublicDefault < ActiveRecord::Migration
  def change
    rename_column :project_attributes, :hidden, :public
    change_column_default :project_attributes, :public, true
  end
end
