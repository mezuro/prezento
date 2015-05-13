class RenameKalibroConfigurationOwnershipsToKalibroConfiugrationAttributes < ActiveRecord::Migration
  def change
    rename_table :kalibro_configuration_ownerships, :kalibro_configuration_attributes
    add_column :kalibro_configuration_attributes, :public, :boolean, default: false
  end
end
