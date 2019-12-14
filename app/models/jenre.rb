class Jenre < ApplicationRecord

  attachment :image

  has_many :users
  has_many :plan

  validates :name, presence: true

end
