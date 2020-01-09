require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'バリデーションのテスト' do

    describe 'アソシエーション' do

      it "Userモデルに属している" do
        is_expected.to belong_to(:user)
      end

      it "Conversationモデルに属している" do
        is_expected.to belong_to(:conversation)
      end
    end

  end
end
