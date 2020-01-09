require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'バリデーションのテスト' do

    describe 'アソシエーション' do
      it "Planモデルを多数持っている" do
        is_expected.to have_many(:plans)
      end

      it "Userモデルに属している" do
        is_expected.to belong_to(:user)
      end
    end

  end
end
