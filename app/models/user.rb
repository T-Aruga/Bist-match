class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image

  belongs_to :jenre


  enum sex: { 男性: 0, 女性: 1 }


  validates :fullname, presence: true, length: { maximum: 50 }

end
