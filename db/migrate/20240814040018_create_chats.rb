class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats do |t|
      t.integer :post_id
      t.integer :user_1_id
      t.integer :user_2_id

      t.timestamps
    end
  end
end
