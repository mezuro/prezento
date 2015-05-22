class CreateMezuroConfigurationOwnerships < ActiveRecord::Migration
  def change
    create_table :mezuro_configuration_ownerships do |t|
      t.integer :user_id
      t.integer :mezuro_configuration_id

      t.timestamps
    end
  end
end
