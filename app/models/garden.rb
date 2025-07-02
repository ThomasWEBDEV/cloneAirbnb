class Garden < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :address, presence: true
  validates :price_per_day, presence: true, numericality: { greater_than: 0 }

  # geolocation
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
