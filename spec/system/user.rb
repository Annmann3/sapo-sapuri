require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー登録機能' do
    context '未ログイン状態' do
      it 'ヘッダーにログイン、新規登録のリンクが表示される' do
        visit root_path
        expect(page).to have_content 'ログイン'
        expect(page).to have_content '新規登録'
      end

      it 'グラフページ、服用履歴ページに遷移しようとするとログインページに遷移する' do
        visit '/graph'
        expect(page).to have_content 'ログイン'
        visit '/dosages'
        expect(page).to have_content 'ログイン'
      end

      it '新規登録ができる' do
        visit root_path
        click_link '新規登録'
        user = build(:user)
        fill_in 'name', with: user.name
        fill_in 'email', with: user.email
        fill_in 'password', with: user.password
        fill_in 'password_confirmation', with: user.password
        click_button '新規登録'
        expect(page).to have_current_path('/graph')
      end
    end
  end
end
