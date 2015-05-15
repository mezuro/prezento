class ChangeKalibroConfigurationAttributesPublicDefault < ActiveRecord::Migration
  def up
    change_column_default :kalibro_configuration_attributes, :public, true
  end

  def down
    change_column_default :kalibro_configuration_attributes, :public, false
  end
end
