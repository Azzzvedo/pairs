class AddTimeToPairingSessions < ActiveRecord::Migration[6.1]
  def change
    add_column :pairing_sessions, :time, :time
  end
end
