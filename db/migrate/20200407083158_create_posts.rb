class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :outfit, foreign_key: true
      t.references :user, foreign_key: true, index: false
      t.date :appointed_day, null: false
      
      t.timestamps
    end

    add_index :posts, [:user_id, :appointed_day], unique: true
  end
end
