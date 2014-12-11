class RenameMezuroConfigurationOwnershipsToKalibroConfigurationOwnerships < ActiveRecord::Migration
  def change
    rename_table :mezuro_configuration_ownerships, :kalibro_configuration_ownerships
  end
end
