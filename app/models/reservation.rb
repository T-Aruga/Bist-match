class Reservation < ApplicationRecord
  enum status: { 未参加: 0, 承認待ち: 1, 承認: 2 }

  belongs_to :plan
  belongs_to :user

  scope :current_week_revenue, -> (user) {
    joins(:plan)
    .where("plans.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?", user.id, 1.week.ago, 2)
    .order(updated_at: :asc)
  }
end
