class CreateRepositoryAttributes < ActiveRecord::Migration
  def change
    create_table :repository_attributes do |t|
      t.integer :repository_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
