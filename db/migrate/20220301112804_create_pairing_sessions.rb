class CreatePairingSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :pairing_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :activity
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :outcome
      t.text :description

      t.timestamps
    end
  end
end
