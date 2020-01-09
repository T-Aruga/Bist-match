require 'rails_helper'

RSpec.describe Jenre, type: :model do
  describe 'バリデーションのテスト' do

    describe 'アソシエーション' do
      it "Planモデルを多数持っている" do
        is_expected.to have_many(:plans)
      end

      it "Userモデルを多数持っている" do
        is_expected.to have_many(:users)
      end
    end

  end
end
