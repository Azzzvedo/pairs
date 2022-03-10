class PairingSession < ApplicationRecord
  belongs_to :user
  has_many :pairing_requests, dependent: :destroy

  ACTIVITIES = %w[climbing tennis cycling golf pool running badminton swimming bowling lacrosse hockey iceskating yoga  fencing basketball rollerblading football ]
  ACTIVITY_LOGOS = { climbing: '🧗🏼', tennis: '🎾', pool: '🎱', golf: '🏌🏾‍♂️', running: '🏃🏿', badminton: '🏸', cycling: '🚴🏽‍♀️', swimming: '🏊🏼', lacrosse: '🥍', hockey: '🏑',iceskating:'⛸' ,rollerblading: '🛼',basketball: '🏀',football: '⚽️',yoga: '🧘🏽‍♀️', bowling: '🎳', fencing: '🤺'}

  validates :activity, presence: true, inclusion: { in: ACTIVITIES }
  validates :address, presence: true
  validates :description, presence: true, length: { maximum: 150 }
  validates :datetime, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
