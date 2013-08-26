class CreateProjectOwnerships < ActiveRecord::Migration
  def change
    create_table :project_ownerships do |t|
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
