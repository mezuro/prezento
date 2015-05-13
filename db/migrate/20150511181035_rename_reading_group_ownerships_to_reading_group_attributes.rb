class RenameReadingGroupOwnershipsToReadingGroupAttributes < ActiveRecord::Migration
  def change
    rename_table :reading_group_ownerships, :reading_group_attributes
    add_column :reading_group_attributes, :public, :boolean, default: false
  end
end
