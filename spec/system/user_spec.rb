require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'User認証のテスト' do
    describe 'User新規登録' do
      before do
        visit new_user_registration_path
      end
      context '新規登録画面に遷移' do
        it '新規登録に成功する' do
          fill_in 'user[fullname]', with: Faker::Internet.username(specifier: 5)
          fill_in 'user[email]', with: Faker::Internet.email
          fill_in 'user[password]', with: 'password'
          click_button 'Sign up'

          expect(page).to have_content 'アカウント登録が完了しました'
        end
        it '新規登録に失敗する' do
          fill_in 'user[fullname]', with: ''
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          click_button 'Sign up'

          expect(page).to have_content '入力されていません'
        end
      end
    end

    describe 'Userログイン' do
      before do
        @user = FactoryBot.create(:user, :active_true)
        visit new_user_session_path
      end
      context 'ログイン画面に遷移' do
        it 'ログインに成功する' do
          fill_in 'user[email]', with: @user.email
          fill_in 'user[password]', with: @user.password
          click_button 'Log in'

          expect(page).to have_content 'ログインしました'
        end

        it 'ログインに失敗する' do
          fill_in 'user[email]', with: ''
          fill_in 'user[password]', with: ''
          click_button 'Log in'

          expect(current_path).to eq(new_user_session_path)
        end
      end
    end
  end

  describe 'Userのテスト' do

    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user)
      FactoryBot.create(:area)
      FactoryBot.create(:jenre)
      FactoryBot.create(:restaurant)
      @plan = FactoryBot.create(:plan)
      visit new_user_session_path
      fill_in 'user[email]', with: @user.email
      fill_in 'user[password]', with: @user.password
      click_button 'Log in'
    end

    describe '編集のテスト' do
      context '自分の編集画面への遷移' do
        it '遷移できる' do
          visit profile_user_path(@user)
          expect(current_path).to eq('/users/' + @user.id.to_s + '/profile')
        end
      end
      context '他人の編集画面への遷移' do
        it '遷移できない' do
          visit profile_user_path(@other_user)
          expect(current_path).to eq('/')
        end
      end

      context '表示の確認' do
        before do
          visit profile_user_path(@user)
        end
        it 'フォームに自分の名前が表示される' do
          expect(page).to have_field 'user[fullname]', with: @user.fullname
        end
        it 'フォームに自分のメールアドレスが表示される' do
          expect(page).to have_field 'user[email]', with: @user.email
        end
        it 'フォームに自分の電話番号が表示される' do
          expect(page).to have_field 'user[phone_number]', with: @user.phone_number
        end
        it 'フォームに自分の性別が表示される' do
          expect(page).to have_field 'user[sex]', with: @user.sex
        end
        it 'フォームに自分の年齢が表示される' do
          expect(page).to have_field 'user[age]', with: @user.age
        end
        it 'フォームに自分の職業が表示される' do
          expect(page).to have_field 'user[job]', with: @user.job
        end
        it '編集に成功する' do
          click_button '保存'
          expect(page).to have_content 'プロフィールを公開'
          expect(current_path).to eq('/users/' + @user.id.to_s)
        end
        it '編集に失敗する' do
          fill_in 'user[fullname]', with: ''
          click_button '保存'
          expect(current_path).to eq('/users/' + @user.id.to_s + '/profile')
        end
      end
    end

    describe 'マイページのテスト' do
      before do
        visit user_path(@user)
      end
      context '表示の確認' do
        it '自分のマイページにはメッセージボタンが表示されない' do
          expect(page).to_not have_content('メッセージを送る')
        end
        it '他ユーザーのマイページにはメッセージボタンが表示される' do
          visit user_path(@other_user)
          expect(page).to have_content('メッセージを送る')
        end
        it 'プラン一覧のplanのリンク先が正しい' do
          expect(page).to have_link @plan.title, href: plan_path(@plan)
        end
      end
    end
  end
end
