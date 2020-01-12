require 'rails_helper'

RSpec.describe Conversation, type: :model do

  before do
    @user = FactoryBot.create(:user)
    @other_user = FactoryBot.create(:user)
    @conversation = FactoryBot.create(:conversation)
  end

  describe 'バリデーションのテスト' do
    describe 'アソシエーション' do
      it "Messageモデルを多数持っている" do
        is_expected.to have_many(:messages)
      end

      it "Userモデルに属している" do
        is_expected.to belong_to(:sender).class_name('User')
        is_expected.to belong_to(:recipient).class_name('User')
      end
    end
  end

  describe 'トークルームの登録' do
    it 'トークルームが登録できること' do
      expect(FactoryBot.create(:conversation)).to be_valid
    end
  end

  describe 'scopes' do
    describe '#between' do
      it '選択した相手とのトークルームを返す' do
        expect(Conversation.between(@user.id, @other_user.id)).to include(@conversation)
      end
    end
  end

  describe '#last_message' do
    it '最新のメッセージを取得できること' do
      message = FactoryBot.create(:message)
      expect(@conversation.last_message).to eq(message)
    end
  end
end
