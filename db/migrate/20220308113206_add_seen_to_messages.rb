class AddSeenToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :seen, :boolean, default: false
  end
end
