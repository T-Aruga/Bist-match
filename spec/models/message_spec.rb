require 'rails_helper'

RSpec.describe Message, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    @conversation = FactoryBot.create(:conversation)
  end

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

  describe 'メッセージの登録' do
    context 'データが正しく保存できる場合' do
      it '正しく登録できること' do
        expect(FactoryBot.create(:message)).to be_valid
      end
    end
  end

  describe '#create_notification' do
    it '通知が正しく登録できること' do
      message = FactoryBot.create(:message)
      expect(message.send(:create_notification)).to be_valid
    end
  end
end
