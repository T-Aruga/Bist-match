require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe 'バリデーションのテスト' do

    describe 'アソシエーション' do
      it "Reservationモデルを多数持っている" do
        is_expected.to have_many(:reservations)
      end

      it "Photoモデルを多数持っている" do
        is_expected.to have_many(:photos)
      end

      it "Guest_reviewモデルを多数持っている" do
        is_expected.to have_many(:guest_reviews)
      end

      it "Favoriteモデルを多数持っている" do
        is_expected.to have_many(:favorites)
      end

      it "Userモデルに属している" do
        is_expected.to belong_to(:user)
      end

      it "Restaurantモデルに属している" do
        is_expected.to belong_to(:restaurant)
      end

      it "Jenreモデルに属している" do
        is_expected.to belong_to(:jenre)
      end

      it "Areaモデルに属している" do
        is_expected.to belong_to(:area)
      end
    end
  end

  describe '食事プランの登録' do
    context 'データが正しく保存できる場合' do
      it '正しく登録できること' do
        FactoryBot.create(:user)
        FactoryBot.create(:area)
        FactoryBot.create(:jenre)
        FactoryBot.create(:restaurant)
        plan = FactoryBot.build(:plan)
        expect(plan).to be_valid
        plan.save

        registered_plan = Plan.find(1);
        expect(registered_plan.title).to eq('sample')
        expect(registered_plan.summary).to eq('sampletext')
        expect(registered_plan.price).to eq(100)
        expect(registered_plan.member).to eq(4)
        expect(registered_plan.plan_date).to eq(1982)
        expect(registered_plan.deadline).to eq(1983)
        expect(registered_plan.requirement).to eq('sampletext')
        expect(registered_plan.longitude).to eq(139.686854)
        expect(registered_plan.latitude).to eq(35.682952)
        expect(registered_plan.restaurant_id).to eq(1)
        expect(registered_plan.jenre_id).to eq(1)
        expect(registered_plan.user_id).to eq(1)
        expect(registered_plan.area_id).to eq(1)
        expect(registered_plan.period_time).to eq("朝")
        expect(registered_plan.status).to eq('募集中')
        expect(registered_plan.is_holiday).to eq(true)
      end
    end

    context 'データの保存が失敗する場合' do
      it "名前が空欄の時、保存に失敗" do
        expect(FactoryBot.build(:plan, :no_title)).to_not be_valid
      end

      it '名前が41文字以上で登録に失敗' do
        expect(FactoryBot.build(:plan, :too_long_title)).to_not be_valid
      end

      it "緯度が存在しないとき、保存に失敗" do
        expect(FactoryBot.build(:plan, :no_latitude)).to_not be_valid
      end

      it "経度が存在しないとき、保存に失敗" do
        expect(FactoryBot.build(:plan, :no_longitude)).to_not be_valid
      end
    end
  end

  describe '#is_ready_plan?' do

    before do
      FactoryBot.create(:user)
      FactoryBot.create(:area)
      FactoryBot.create(:jenre)
      FactoryBot.create(:restaurant)
      @plan = FactoryBot.create(:plan)
      FactoryBot.create(:photo)
    end

    it '入力項目が登録されていればtrue' do
      expect(@plan.is_ready_plan?).to be_truthy
    end

    it '入力項目が登録されていなければばfalse' do
      @plan = FactoryBot.create(:plan, :no_price)
      expect(@plan.is_ready_plan?).to be_falsey
    end
  end

  describe 'scopes' do
    describe '#available' do
      before do
        FactoryBot.create(:user)
        FactoryBot.create(:area)
        FactoryBot.create(:jenre)
        FactoryBot.create(:restaurant)
        @plan = FactoryBot.create(:plan, :true_active)
        @other_plan = FactoryBot.create(:plan, :false_active)
        FactoryBot.create(:photo)
      end

      it '利用可能なプランを返す' do
        expect(Plan.available).to include(@plan)
      end

      it '利用不可のプランが含まれていない' do
        expect(Plan.available).to_not include(@other_plan)
      end
    end
  end

  describe '#favorite_methods' do

    before do
      @user = FactoryBot.create(:user)
      FactoryBot.create(:area)
      FactoryBot.create(:jenre)
      FactoryBot.create(:restaurant)
      @plan = FactoryBot.create(:plan)
      FactoryBot.create(:favorite)
    end

    it 'いいねが保存できる' do
      expect(@plan.good(@user)).to be_valid
    end

    it 'いいねが削除できる' do
      expect(@plan.ungood(@user)).to be_valid
    end

    it 'いいね済みならtrue' do
      expect(@plan.good?(@user)).to be_truthy
    end

    it 'いいねが存在していなければfalse' do
      favorite = Favorite.find(1)
      favorite.destroy
      expect(@plan.good?(@user)).to be_falsey
    end
  end

  describe '#add_restinfo' do

    before do
      FactoryBot.create(:user)
      FactoryBot.create(:area)
      FactoryBot.create(:jenre)
      @restaurant = FactoryBot.create(:restaurant)
    end

    it 'プランに飲食店情報が追加される' do
      @plan = FactoryBot.build(:plan, :no_restinfo)
      @plan.add_restinfo(@restaurant)
      expect(@plan).to be_valid
    end
  end
end
