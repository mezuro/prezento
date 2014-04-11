class AddCloneInformationToMezuroConfigurationOwnership < ActiveRecord::Migration
  def change
    add_column :mezuro_configuration_ownerships, :fork_count, :int, default: 0, null: false
    add_column :mezuro_configuration_ownerships, :parent_id, :int
  end
end
