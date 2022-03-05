class PairingSession < ApplicationRecord
  belongs_to :user
  has_many :pairing_requests, dependent: :destroy

  ACTIVITIES = %w[climbing tennis pool squash golf running badminton cycling swimming]
  ACTIVITY_LOGOS = { climbing: '🧗‍♀️', tennis: '🎾', pool: '🎱', squash: '', golf: '🏌️‍♂️', running: '🏃🏿', badminton: '🏸', cycling: '🚴🏽‍♀️', swimming: '🏊🏼' }

  validates :activity, presence: true, inclusion: { in: ACTIVITIES }
  validates :address, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 150 }
  validates :datetime, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
