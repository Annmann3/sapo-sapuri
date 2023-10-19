require 'rails_helper'

RSpec.describe 'グラフ機能', type: :system do
  let(:user) { create(:user) }
  describe 'グラフ表示機能' do
    context 'ログイン状態' do
      it 'グラフページに遷移するとグラフが表示される' do
        login(user)
        expect(page).to have_selector('canvas#line-chart')
      end
    end
  end
end
