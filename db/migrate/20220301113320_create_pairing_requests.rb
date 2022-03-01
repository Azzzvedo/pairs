class CreatePairingRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :pairing_requests do |t|
      t.references :pairing_session, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :approved
      t.text :introduction

      t.timestamps
    end
  end
end
