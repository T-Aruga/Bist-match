class Reservation < ApplicationRecord
  enum status: { 未参加: 0, 承認待ち: 1, 承認: 2 }

  after_create_commit :create_notification

  belongs_to :plan
  belongs_to :user

  scope :current_week_revenue, lambda { |user|
    joins(:plan)
      .where('plans.user_id = ? AND reservations.updated_at >= ? AND reservations.status = ?', user.id, 1.week.ago, 2)
      .order(updated_at: :asc)
  }

  private

  # 参加申請時に、ホストに通知を送る
  def create_notification
    guest = User.find(user_id)
    notification = Notification.create(content: "#{guest.fullname}さんから参加申請がありました", user_id: plan.user_id)
    notification.user.increment!(:unread)
  end
end
