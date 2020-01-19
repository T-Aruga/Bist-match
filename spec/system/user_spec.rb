require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
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

  describe 'ユーザーログイン' do
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

# RSpec.feature "Homeページ、サインアップ、ログイン、ログアウトに関するテスト", type: :system do
#   before do
#     @user = FactoryBot.create(:user, :active_true)
#   end

#   feature "サインアップの確認" do
#     before do
#       visit new_user_registration_path
#       find_field('user[fullname]').set("sample taro")
#       find_field('user[email]').set("aa@aa")
#       find_field('user[password]').set("pppppp")
#     end

#     scenario "正しくサインアップできているか" do
#       expect {
#         find("input[fullname='commit']").click
#       }.to change(User, :count).by(1)
#     end

#     scenario "リダイレクト先は正しいか" do
#       find("input[name='commit']").click
#       expect(page).to have_current_path profile_user_path(User.last)
#     end

#     scenario "サクセスメッセージは正しく表示されるか" do
#       find("input[name='commit']").click
#       expect(page).to have_content "アカウント登録が完了しました"
#     end
#   end

#   feature "有効でない内容でのサインアップの確認" do
#     before do
#       visit new_user_registration_path
#       find_field('user[fullname]').set(nil)
#       find_field('user[email]').set("bb@bb")
#       find_field('user[password]').set("pppppp")
#       find("input[name='commit']").click
#     end
#     scenario "エラーメッセージは正しく表示されるか" do
#       expect(page).to have_content "入力されていません"
#     end
#   end

#   feature "ログインの確認" do
#     before do
#       visit new_user_session_path
#       find_field('user[email]').set(@user.email)
#       find_field('user[password]').set(@user.password)
#       find("input[name='commit']").click
#     end

#     scenario "正しくログインして、リダイレクトされているか" do
#       expect(page).to have_current_path root_path
#     end

#     scenario "サクセスメッセージは正しく表示されるか" do
#       expect(page).to have_content "ログインしました"
#     end
#   end

#   feature "有効でない内容でのログインの確認" do
#     before do
#       visit new_user_session_path
#       find_field('user[email]').set(nil)
#       find_field('user[password]').set(nil)
#       find("input[name='commit']").click
#     end
#     scenario "リダイレクト先は正しいか" do
#       expect(page).to have_current_path new_user_session_path
#     end
#   end

#   feature "ログアウトの確認" do
#     before do
#       login(@user)
#       visit root_path
#       all("a[data-method='delete'][href='/users/sign_out']")[0].click
#      # click_on "logout"
#     end
#     scenario "正しくログアウトして、リダイレクトされているか" do
#       expect(page).to have_current_path "/"
#     end
#     scenario "サクセスメッセージは正しく表示されるか" do
#       expect(page).to have_content "ログアウトしました"
#     end
#   end

#   feature "ヘッダーのリンクの確認" do
#     scenario "ログイン時" do
#       login(@user)
#       visit root_path
#       expect(page).to have_link "",href: dashboard_path
#       expect(page).to have_link "",href: new_plan_path
#       expect(page).to have_link "",href: plans_path
#       expect(page).to have_link "",href: your_reservation_path
#       expect(page).to have_link "",href: your_entry_path
#       expect(page).to have_link "",href: user_path(@user)
#       expect(page).to have_link "",href: profile_user_path(@user)
#       expect(page).to have_link "",href: conversations_path
#       expect(page).to have_link "",href: revenues_path
#       expect(page).to have_link "",href: payment_method_path
#       expect(page).to have_link "",href: exit_user_path(@user)
#       expect(page).to have_link "",href: destroy_user_session_path
#     end

#     scenario "ログアウト時" do
#       visit root_path
#       expect(page).to have_link "",href: new_user_session_path
#       expect(page).to have_link "",href: new_user_registration_path
#       expect(page).to have_link "",href: about_path
#     end
#   end
# end

# RSpec.feature 'Home', type: :system do
#   scenario 'shows greeting' do
#     visit root_path
#     expect(page).to have_content 'Hello World!'
#   end
# end
