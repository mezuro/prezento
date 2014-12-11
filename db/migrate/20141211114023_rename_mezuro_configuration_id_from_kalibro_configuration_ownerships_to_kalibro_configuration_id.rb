class RenameMezuroConfigurationIdFromKalibroConfigurationOwnershipsToKalibroConfigurationId < ActiveRecord::Migration
  def change
    rename_column :kalibro_configuration_ownerships, :mezuro_configuration_id, :kalibro_configuration_id
  end
end
