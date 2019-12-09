class Restaurant < ApplicationRecord

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :pc_url, presence: true
  validates :address, presence: true
end
