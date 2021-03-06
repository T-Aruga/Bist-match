class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  attachment :image

  has_many :plans, dependent: :destroy
  has_many :restaurants, dependent: :destroy
  has_many :reservations, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :guest_reviews, class_name: 'GuestReview', foreign_key: 'guest_id'
  has_many :host_reviews, class_name: 'HostReview', foreign_key: 'host_id'
  has_many :notifications

  belongs_to :jenre, optional: true

  enum sex: { 男性: 0, 女性: 1 }

  validates :fullname, presence: true, length: { maximum: 30 }

  # omniauthのコールバック時に呼ばれる
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.fullname = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # プロフィールの項目が入力されているか確認する
  def is_ready_user?
    !active && fullname.present? && email.present? && description.present? && image_id.present? && favorite_store.present? && jenre_id.present?
  end
end
