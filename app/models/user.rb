class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  has_many :plans, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :guest_reviews, class_name: "GuestReview", foreign_key: "guest_id"
  has_many :host_reviews, class_name: "HostReview", foreign_key: "host_id"


  belongs_to :jenre


  enum sex: { 男性: 0, 女性: 1 }


  validates :fullname, presence: true, length: { maximum: 50 }


  def is_ready_user?
    !self.active && !self.fullname.blank? && !self.email.blank? && !self.description.blank? && !self.image_id.blank? && !self.favorite_store.blank? && !self.jenre_id.blank?
  end
end
