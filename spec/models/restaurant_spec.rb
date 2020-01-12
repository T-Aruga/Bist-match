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

  describe '飲食店情報の登録' do
    context 'データが正しく保存できる場合' do
      it 'データが正しく保存できること' do
        FactoryBot.create(:user)
        expect(FactoryBot.create(:restaurant)).to be_valid
      end
    end

    context 'データの保存が失敗する場合' do
      it '名前が空欄の時、保存に失敗' do
        FactoryBot.create(:user)
        expect(FactoryBot.build(:restaurant, :no_name)).to_not be_valid
      end
    end
  end
end
