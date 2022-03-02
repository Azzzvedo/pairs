class ChangeTimeDatatypeToPairingSessions < ActiveRecord::Migration[6.1]
  def change
    remove_column :pairing_sessions, :time, :time
    add_column :pairing_sessions, :datetime, :datetime
    add_column :pairing_sessions, :time, :integer
  end
end
