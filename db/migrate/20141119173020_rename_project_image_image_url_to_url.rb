class RenameProjectImageImageUrlToUrl < ActiveRecord::Migration
  def change
    change_table :project_images do |t|
      t.rename :image_url, :url
    end
  end
end
