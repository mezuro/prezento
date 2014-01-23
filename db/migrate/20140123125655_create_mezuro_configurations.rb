class CreateMezuroConfigurations < ActiveRecord::Migration
  def change
    create_table :mezuro_configurations do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
