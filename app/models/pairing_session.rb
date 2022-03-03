class PairingSession < ApplicationRecord
  belongs_to :user
  has_many :pairing_requests

  ACTIVITIES = %w[climbing jai\ alai fencing]
  TIMES = [0, 15, 30, 45, 60]

  validates :activity, presence: true, inclusion: { in: ACTIVITIES }
  validates :address, presence: true
  validates :description, presence: true, length: { minimum: 10, maximum: 150 }
  validates :time, presence: true, inclusion: { in: TIMES }

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  after_validation :time_to_datetime

  def time_to_datetime
    self.datetime = DateTime.now + (self.time.to_f / (24 * 60))
  end

end
