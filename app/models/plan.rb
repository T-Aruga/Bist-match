class Plan < ApplicationRecord

  enum status: { 募集終了: 0, 募集中: 1 }
  enum period_time: { 朝: 0, ランチタイム: 1, 夕方・夜:2 }

  has_many :reservations, dependent: :destroy
  has_many :photos, dependent: :destroy
  accepts_attachments_for :photos, attachment: :image

  has_many :guest_reviews
  has_many :favorites, dependent: :destroy

  belongs_to :user
  belongs_to :restaurant
  belongs_to :jenre
  belongs_to :area

  geocoded_by :address


  # プランにいいね
  def good(user)
    favorites.create(user_id: user.id)
  end

  def ungood(user)
    favorites.find_by(user_id: user.id).destroy
  end

  def good?(user)
    user_ids = favorites.pluck(:user_id)
    user_ids.include?(user.id)
  end

  # レビューの平均点の取得
  def average_rating
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end

  # プランの入力情報があるか確認
  def is_ready_plan?
    !self.active && !self.price.blank? && !self.member.blank? && !self.jenre_id.blank? && !self.status.blank? && !self.area_id.blank? &&
    !self.restaurant.name.blank? && !self.restaurant.address.blank? && !self.restaurant.line.blank? && !self.restaurant.station.blank? &&
    !self.restaurant.walk.blank? && !self.summary.blank? && !self.title.blank? && !self.requirement.blank? && !self.photos.blank? &&
    !self.plan_date.blank? && !self.start_time.blank? && !self.end_time.blank? && !self.deadline.blank?
  end
end
