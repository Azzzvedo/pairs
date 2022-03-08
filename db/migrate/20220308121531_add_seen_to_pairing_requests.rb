class AddSeenToPairingRequests < ActiveRecord::Migration[6.1]
  def change
    add_column :pairing_requests, :seen, :boolean, default: false
  end
end
