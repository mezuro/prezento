class AddImageUrlToProjectOwnerships < ActiveRecord::Migration
  def change
    add_column :project_ownerships, :image_url, :string
  end
end
