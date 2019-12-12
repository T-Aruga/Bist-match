class Restaurant < ApplicationRecord

  has_many :plans

  geocoded_by :address
  after_validation :geocode, if: :address_present?

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :pc_url, presence: true
  validates :address, presence: true
end
