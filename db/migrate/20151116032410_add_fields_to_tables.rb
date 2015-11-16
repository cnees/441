class AddFieldsToTables < ActiveRecord::Migration
  def change
    add_column :reposts, :user_id, :integer
    add_column :reposts, :clip_id, :integer
  end
end
