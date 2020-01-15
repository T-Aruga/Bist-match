require 'rails_helper'

RSpec.describe HostReview, type: :model do
  describe 'バリデーションのテスト' do

    describe 'アソシエーション' do
      it "Userモデルに属している" do
        is_expected.to belong_to(:host).class_name('User')
      end
    end
  end
end
