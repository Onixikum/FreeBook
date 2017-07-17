class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :book_id
      t.integer :user_id
      t.string  :content

      t.timestamps
    end

    add_index :comments, [:book_id, :user_id]
  end
end
