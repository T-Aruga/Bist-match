require 'rails_helper'

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe 'バリデーションのテスト' do
    context 'アソシエーション' do
      it "Planモデルを多数持っている" do
        is_expected.to have_many(:plans)
      end

      it "Restaurantモデルを多数持っている" do
        is_expected.to have_many(:restaurants)
      end

      it "Reservationモデルを多数持っている" do
        is_expected.to have_many(:reservations)
      end

      it "Favoriteモデルを多数持っている" do
        is_expected.to have_many(:favorites)
      end

      it "Notificationモデルを多数持っている" do
        is_expected.to have_many(:notifications)
      end

      it "Guest_reviewモデルを多数持っている" do
        is_expected.to have_many(:guest_reviews)
      end

      it "Host_reviewモデルを多数持っている" do
        is_expected.to have_many(:host_reviews)
      end

      it "Jenreモデルに属している" do
        is_expected.to belong_to(:jenre).optional
      end

    end
  end
end
