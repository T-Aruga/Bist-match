class Plan < ApplicationRecord

  has_many :reservations, dependent: :destroy
  has_many :photos, dependent: :destroy
  accepts_attachments_for :photos, attachment: :image

  has_many :guest_reviews

  belongs_to :user
  belongs_to :restaurant
  belongs_to :jenre
  belongs_to :area



  enum status: { 募集終了: 0, 募集中: 1 }
  enum period_time: { 朝: 0, ランチタイム: 1, 夕方・夜:2 }

  # レビューの平均点の取得
  def average_rating
    guest_reviews.count == 0 ? 0 : guest_reviews.average(:star).round(2).to_i
  end
end
