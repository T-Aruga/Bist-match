require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'バリデーションのテスト' do

    describe 'アソシエーション' do
      it "Userモデルに属している" do
        is_expected.to belong_to(:user)
      end

      it "Planモデルに属している" do
        is_expected.to belong_to(:plan)
      end
    end

  end
end
