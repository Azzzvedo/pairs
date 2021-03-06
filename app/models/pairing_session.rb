class PairingSession < ApplicationRecord
  belongs_to :user
  has_many :pairing_requests, dependent: :destroy

  ACTIVITIES = %w[climbing tennis cycling golf pool running badminton swimming bowling lacrosse hockey iceskating yoga  fencing basketball rollerblading football ]
  ACTIVITY_LOGOS = { climbing: 'ð§ðž', tennis: 'ðū', pool: 'ðą', golf: 'ððūââïļ', running: 'ððŋ', badminton: 'ðļ', cycling: 'ðīð―ââïļ', swimming: 'ððž', lacrosse: 'ðĨ', hockey: 'ð',iceskating:'âļ' ,rollerblading: 'ðž',basketball: 'ð',football: 'â―ïļ',yoga: 'ð§ð―ââïļ', bowling: 'ðģ', fencing: 'ðĪš'}

  validates :activity, presence: true, inclusion: { in: ACTIVITIES }
  validates :address, presence: true
  validates :description, presence: true, length: { maximum: 150 }
  validates :datetime, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
