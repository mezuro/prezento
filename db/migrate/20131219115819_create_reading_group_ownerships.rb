class CreateReadingGroupOwnerships < ActiveRecord::Migration
  def change
    create_table :reading_group_ownerships do |t|
      t.integer :user_id
      t.integer :reading_group_id

      t.timestamps
    end
  end
end
