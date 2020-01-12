require 'rails_helper'

RSpec.describe Reservation, type: :model do

  before do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:area)
    FactoryBot.create(:jenre)
    FactoryBot.create(:restaurant)
    FactoryBot.create(:plan)
  end

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

  describe '参加情報の登録' do
    context 'データが正しく保存できる場合' do
      it '正しく登録できること' do
        expect(FactoryBot.create(:reservation)).to be_valid
      end
    end
  end

  describe 'scopes' do
    describe '#current_week_revenue' do
      it '今週の収入対象の参加予約を返す' do
        reservation = FactoryBot.create(:reservation, :approved)
        expect(Reservation.current_week_revenue(@user)).to include(reservation)
      end
    end
  end

  describe '#create_notification' do
    it '通知が正しく登録できること' do
      reservation = FactoryBot.create(:reservation)
      expect(reservation.send(:create_notification)).to be_valid
    end
  end
end
