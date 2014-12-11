class CreateKalibroConfigurationOwnerships < ActiveRecord::Migration
  def change
    create_table :kalibro_configuration_ownerships do |t|
      t.integer :user_id
      t.integer :kalibro_configuration_id

      t.timestamps
    end
  end
end
