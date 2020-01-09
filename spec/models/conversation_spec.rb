require 'rails_helper'

RSpec.describe Conversation, type: :model do

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
end
