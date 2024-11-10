class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :price
      t.string :seller_name
      t.boolean :is_sold
      t.boolean :is_receive

      t.timestamps
    end
  end
end
