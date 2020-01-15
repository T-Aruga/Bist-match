require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'バリデーションのテスト' do

    context 'アソシエーション' do
      it "Userモデルに属している" do
        is_expected.to belong_to(:user)
      end
    end
  end
end
