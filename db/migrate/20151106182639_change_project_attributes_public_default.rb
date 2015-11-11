class ChangeProjectAttributesPublicDefault < ActiveRecord::Migration
  def up
    rename_column :project_attributes, :hidden, :public
    change_column_default :project_attributes, :public, true

    ProjectAttributes.all.update_all('public = NOT public')
  end

  def down
    rename_column :project_attributes, :public, :hidden
    change_column_default :project_attributes, :hidden, false

    ProjectAttributes.all.update_all('hidden = NOT hidden')
  end
end
