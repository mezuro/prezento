class AddPublicToRepositoryAttributes < ActiveRecord::Migration
  def change
    add_column :repository_attributes, :public, :boolean, default: true
  end
end
