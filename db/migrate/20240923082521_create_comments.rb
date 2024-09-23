class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.string :title
      t.text :content
      t.integer :user_id
      t.integer :post_id
      t.integer :parent_id
      t.timestamps
    end
  end
end
