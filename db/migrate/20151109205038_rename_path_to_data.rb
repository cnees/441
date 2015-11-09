class RenamePathToData < ActiveRecord::Migration
  def change
    rename_column :clips, :path, :data
  end
end