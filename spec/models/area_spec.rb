require 'rails_helper'

RSpec.describe Area, type: :model do

  describe 'バリデーションのテスト' do

    describe 'アソシエーション' do
      it "Planモデルを多数持っている" do
        is_expected.to have_many(:plans)
      end
    end

  end
end
