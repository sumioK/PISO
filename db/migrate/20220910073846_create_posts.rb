class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null:false
      t.string :image, null:false
      t.string :content

      t.timestamps
    end
  end
end
