class CreateClips < ActiveRecord::Migration
  def change
    create_table :clips do |t|
      t.text :path
      t.integer :faves
      t.timestamps null: false
    end
    add_reference :clips, :user, index: true
  end
end