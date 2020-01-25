require 'rails_helper'

RSpec.describe "Plans", type: :system do
  describe 'Planのテスト' do

    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
      FactoryBot.create(:area)
      FactoryBot.create(:jenre)
      FactoryBot.create(:restaurant)
      @plan = FactoryBot.create(:plan)
      @other_plan = FactoryBot.create(:plan, :other_user)
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Log in'
    end

    describe '編集のテスト' do
      context '自分のプラン編集画面への遷移' do
        it '遷移できる' do
          visit listing_plan_path(@plan)
          expect(current_path).to eq('/plans/' + @plan.id.to_s + '/listing')
        end
      end
      context '他人のプラン編集画面への遷移' do
        it '遷移できない' do
          visit listing_plan_path(@other_plan)
          expect(current_path).to eq('/')
        end
      end

      context '表示の確認' do

        before do
          visit listing_plan_path(@plan)
        end

        it '編集に成功する' do
          click_button '保存'
          expect(page).to have_content '編集内容を保存しました'
          expect(current_path).to eq('/plans/' + @plan.id.to_s + '/listing')
        end
        it '編集に失敗する' do
          fill_in 'plan[price]', with: ''
          click_button '保存'
          expect(current_path).to eq('/plans/' + @plan.id.to_s + '/listing')
        end
      end
    end

    describe 'いいねのテスト' do
      it 'プランにいいねができる' do
        visit plan_path(@plan)
        expect(page).to have_css('.far')
        expect {
          first('.far').click
          wait_for_ajax
        }.to change{ @plan.favorites.count }.by(1)
      end

      it 'プランにしたいいねを取り消せる' do
        visit plan_path(@plan)
        expect(page).to_not have_css('fa')
        expect {
          first('.far').click
          wait_for_ajax
          first('.fa').click
          wait_for_ajax
        }.to change{ @plan.favorites.count }.by(0)
      end
    end

    describe 'プランの予約のテスト' do
      it 'プランに参加申請が出来る' do
        visit plan_path(@other_plan)
        fill_in 'reservation[price]', with: @other_plan.price
        click_button 'このプランに参加する'
        expect(page).to have_content 'プランに参加希望をしました'
      end

      it '参加申請済みプランへ予約が重複してできない' do
        FactoryBot.create(:reservation, :other_plan)
        visit plan_path(@other_plan)
        fill_in 'reservation[price]', with: @other_plan.price
        click_button 'このプランに参加する'
        expect(page).to have_content 'このプランに参加希望は出せません'
      end

      it '料金が最低金額以下の場合、参加申請ができない' do
        visit plan_path(@other_plan)
        fill_in 'reservation[price]', with: 10
        click_button 'このプランに参加する'
        expect(page).to have_content 'ホストへの支払額が最低金額を満たしていません'
      end

      it 'クレカ登録がされていないと参加申請ができない' do
        @user.update(stripe_id: '')
        visit plan_path(@other_plan)
        fill_in 'reservation[price]', with: @other_plan.price
        click_button 'このプランに参加する'
        expect(page).to have_content 'クレジットカードを登録して下さい'
        expect(current_path).to eq('/payment_method')
      end
    end
  end
end
