class Restaurant < ApplicationRecord

  has_many :plans
  belongs_to :user

  geocoded_by :address

  validates :name, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
  validates :pc_url, presence: true
  validates :address, presence: true
end
