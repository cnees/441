class AddNameToClip < ActiveRecord::Migration
  def change
    add_column :clips, :name, :text
  end
end
