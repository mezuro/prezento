class CreateProjectImages < ActiveRecord::Migration
  def change
    create_table :project_images do |t|
    	t.belongs_to :project
      t.string :image_url

      t.timestamps
    end
  end
end
