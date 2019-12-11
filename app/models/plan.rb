class Plan < ApplicationRecord


  has_many :photos, dependent: :destroy
  accepts_attachments_for :photos, attachment: :image

  belongs_to :user
  belongs_to :restaurant



  enum status: { 募集終了: 0, 募集中: 1 }
end
