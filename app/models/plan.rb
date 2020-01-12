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

  validates :title, presence: true, length: { maximum: 40 }
  validates :latitude, presence: true
  validates :longitude, presence: true

  # 募集中の利用可能なプランを取得
  scope :available, -> {
      where("status = ? AND active = ?", 1, true)
  }


  # プランにいいね
  def good(user)
    favorites.create(user_id: user.id)
  end

  # いいねを取り消す
  def ungood(user)
    favorites.find_by(user_id: user.id).destroy
  end

  # いいね済みかどうか確認
  def good?(user)
    user_ids = favorites.pluck(:user_id)
    user_ids.include?(user.id)
  end

  # プランに必要なrestaurantの情報を追加する
  def add_restinfo(rest)
    self.restaurant_id = rest.id
    self.latitude = rest.latitude
    self.longitude = rest.longitude
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
