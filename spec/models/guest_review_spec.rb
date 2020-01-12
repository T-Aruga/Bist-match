require 'rails_helper'

RSpec.describe GuestReview, type: :model do
  describe 'バリデーションのテスト' do

    describe 'アソシエーション' do
      it "Userモデルに属している" do
        is_expected.to belong_to(:guest).class_name('User')
      end
    end

  end
end
