class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.string :cover_photo_link
      t.integer :author_id
      t.integer :status

      t.timestamps
    end
  end
end
