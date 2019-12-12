class Reservation < ApplicationRecord

  belongs_to :plan
  belongs_to :user

  enum status: { 未参加: 0, 承認待ち: 1, 承認: 2 }
end
