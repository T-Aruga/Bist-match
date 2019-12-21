class Jenre < ApplicationRecord

  attachment :image

  has_many :users
  has_many :plans

  validates :name, presence: true

end
