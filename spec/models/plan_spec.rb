require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe 'バリデーションのテスト' do

    describe 'アソシエーション' do
      it "Reservationモデルを多数持っている" do
        is_expected.to have_many(:reservations)
      end

      it "Photoモデルを多数持っている" do
        is_expected.to have_many(:photos)
      end

      it "Guest_reviewモデルを多数持っている" do
        is_expected.to have_many(:guest_reviews)
      end

      it "Favoriteモデルを多数持っている" do
        is_expected.to have_many(:favorites)
      end

      it "Userモデルに属している" do
        is_expected.to belong_to(:user)
      end

      it "Restaurantモデルに属している" do
        is_expected.to belong_to(:restaurant)
      end

      it "Jenreモデルに属している" do
        is_expected.to belong_to(:jenre)
      end

      it "Areaモデルに属している" do
        is_expected.to belong_to(:area)
      end
    end

  end
end
