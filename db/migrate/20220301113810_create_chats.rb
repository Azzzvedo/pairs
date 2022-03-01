class CreateChats < ActiveRecord::Migration[6.1]
  def change
    create_table :chats do |t|
      t.references :sender
      t.references :recipient

      t.timestamps
    end

    add_foreign_key :chats, :users, column: :sender_id, primary_key: :id
    add_foreign_key :chats, :users, column: :recipient_id, primary_key: :id
  end
end
