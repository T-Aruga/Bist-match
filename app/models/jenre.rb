class Jenre < ApplicationRecord

  attachment :image

  has_many :users

  validates :name, presence: true

end
