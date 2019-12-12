class Plan < ApplicationRecord


  has_many :photos, dependent: :destroy
  accepts_attachments_for :photos, attachment: :image

  belongs_to :user
  belongs_to :restaurant
  belongs_to :jenre
  belongs_to :area



  enum status: { 募集終了: 0, 募集中: 1 }
  enum period_time: { 朝: 0, ランチタイム: 1, 夕方・夜:2 }
end
