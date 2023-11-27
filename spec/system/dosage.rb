require 'rails_helper'

# このテストだけselenium chrome driverを使う
RSpec.describe '服用記録', type: :system, js: true do
  describe '服用管理のCRUD' do
    let(:user) { create(:user) }
    let!(:nutrient) { create(:nutrient) }
    let(:dosage) { create(:dosage, user: user, nutrient: nutrient) }
    context 'ログインしていないとき' do
      it '服用記録一覧画面に遷移できない' do
        visit '/dosages'
        expect(current_path).to eq '/login'
      end
    end

    context 'ログインしているとき' do
      before do
        login(user)
      end

      it '服用履歴画面が表示される' do
        visit '/dosages'
        expect(page).to have_content '服用履歴'
      end
      it '服用記録ボタンを押すと、服用登録フォームが表示され、サプリの種類、日付、時間、容量が表示されている' do
        visit '/dosages'
        click_button '服用記録を追加'
        expect(page).to have_content '服用登録'
        expect(page).to have_content 'ビタミンC'
        # 現在時刻が入力済みであることを確認
        expect(find('#dp-input-dosage_date').value).to eq Time.zone.now.strftime('%Y/%m/%d')
        expect(find('#dp-input-dosage_time').value).to have_content Time.zone.now.strftime('%H:%M')
      end
      it '各項目を入力後に服用登録ボタン押すと、入力フォームが消えて服用記録が登録されている' do
        visit '/dosages'
        click_button '服用記録を追加'
        fill_in 'amount', with: 300
        click_button '登録'
        expect(page).not_to have_content '服用登録'
        expect(page).to have_content 300
      end
      it '編集フォームから服用記録を削除すると、服用記録が削除される' do
        dosage
        visit '/dosages'
        expect(page).to have_selector("tr#dosage-#{dosage.id}")
        click_on "edit-button-dosage-#{dosage.id}"
        click_on '削除'
        expect(page).to have_content '服用履歴'
        expect(page).not_to have_selector("tr#dosage-#{dosage.id}")
      end
      it '編集フォームから服用記録を編集すると、服用記録が編集される' do
        dosage
        visit '/dosages'
        expect(page).to have_selector("tr#dosage-#{dosage.id}")
        click_on "edit-button-dosage-#{dosage.id}"
        fill_in 'amount', with: dosage.amount + 100
        click_on '更新'
        expect(page).to have_content '服用履歴'
        expect(page).to have_content dosage.amount + 100
      end
    end
  end
end
