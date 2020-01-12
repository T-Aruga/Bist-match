require 'rails_helper'
require "refile/file_double"

RSpec.describe User, "モデルに関するテスト", type: :model do
  describe 'バリデーションのテスト' do
    describe 'アソシエーション' do
      it "Planモデルを多数持っている" do
        is_expected.to have_many(:plans)
      end

      it "Restaurantモデルを多数持っている" do
        is_expected.to have_many(:restaurants)
      end

      it "Reservationモデルを多数持っている" do
        is_expected.to have_many(:reservations)
      end

      it "Favoriteモデルを多数持っている" do
        is_expected.to have_many(:favorites)
      end

      it "Notificationモデルを多数持っている" do
        is_expected.to have_many(:notifications)
      end

      it "Guest_reviewモデルを多数持っている" do
        is_expected.to have_many(:guest_reviews)
      end

      it "Host_reviewモデルを多数持っている" do
        is_expected.to have_many(:host_reviews)
      end

      it "Jenreモデルに属している" do
        is_expected.to belong_to(:jenre).optional
      end
    end
  end


  describe 'ユーザーデータの登録' do
    context 'データが保存できる場合' do
      it '正しく登録できること' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
        user.save

        registered_user = User.find(1);
        expect(registered_user.fullname).to eq('Alice Stark')
        expect(registered_user.email).to eq('tester1@example.com')
        expect(registered_user.phone_number).to eq('11144448888')
        expect(registered_user.description).to eq('sample text')
        expect(registered_user.sex).to eq("女性")
        expect(registered_user.age).to eq(24)
        expect(registered_user.favorite_store).to eq('マクドナルド')
        expect(registered_user.job).to eq('会社員')
        expect(registered_user.jenre_id).to eq(2)
      end

      it '画像データの保存ができること' do
        expect(FactoryBot.create(:user, :create_with_image)).to be_valid
      end
    end

    context 'データの保存が失敗する場合' do
      it "名前が空欄の時、保存に失敗" do
        expect(FactoryBot.build(:user, :no_name)).to_not be_valid
      end

      it '名前が31文字以上で登録に失敗' do
        expect(FactoryBot.build(:user, :too_long_name)).to_not be_valid
      end
    end
  end

  describe '#is_ready_user?' do
    it '入力項目が登録されていればtrue' do
      user = FactoryBot.create(:user)
      expect(user.is_ready_user?).to be_truthy
    end

    it '入力項目が登録されていなければばfalse' do
      user = FactoryBot.create(:user, :no_description)
      expect(user.is_ready_user?).to be_falsey
    end
  end
end
