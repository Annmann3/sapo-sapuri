require 'rails_helper'

RSpec.describe 'グラフ機能', type: :system, js: true do
  let(:user) { create(:user) }
  describe 'グラフ表示機能' do
    context 'ゲストユーザーのグラフ機能' do
      it '登録ユーザーのグラフページに遷移するとグラフが表示される' do
        visit '/guest-graph'
        expect(page).to have_selector('canvas#line-chart')
      end
      it '服用フォームから登録するとグラフが表示される' do
        visit '/guest-graph'
        click_button '服用'
        expect(page).to have_selector('canvas#line-chart')
      end
    end
    context '登録ユーザーのグラフ機能' do
      before do
        login(user)
      end
      it 'グラフページに遷移するとグラフが表示される' do
        visit '/graph'
        expect(page).to have_selector('canvas#line-chart')
      end
      it 'グラフページに１週間の達成率が表示される' do
        visit '/graph'
        expect(page).to have_content('１週間の達成率')
        expect(page).to have_content('0%')
      end
      it '服用フォームから登録するとグラフと次のライン到達時刻が表示される' do
        visit '/graph'
        click_button '服用'
        expect(page).to have_selector('canvas#line-chart')
        expect(page).to have_content('次のライン到達時刻')
        expect(page).to have_content(9.hours.from_now.strftime('%H:%M'))
      end
    end
  end
end
