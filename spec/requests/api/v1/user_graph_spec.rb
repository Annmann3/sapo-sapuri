require 'rails_helper'

RSpec.describe 'UserGraphAPI', type: :request do
  describe 'GET /api/v1/user_graph' do
    let(:user) { create(:user) }
    let(:auth_header) { login(user) }

    context '過去1週間以内の服用記録が存在するとき' do
      let!(:dosage_in_week) { create(:dosage, dosage_at: 3.days.ago, user: user) }
      let!(:dosage) { create(:dosage, dosage_at: 2.weeks.ago, user: user) }

      it '過去1週間以内グラフデータ、目標値、達成率を取得できること' do
        get api_v1_user_graph_index_path, headers: auth_header
        json = JSON.parse(response.body)
        graph_data = json['graph_data']

        expect(response).to have_http_status(:ok)
        expect(json).to include('graph_data', 'goal', 'achievement_rate')
        expect(graph_data[0]['x'] > 1.week.ago).to be_truthy
        expect(graph_data.any? { |data| data['y'] >= 0 }).to be_truthy
      end
    end
    context '過去1週間以内の服用記録が存在しないとき' do
      let!(:dosage_in_week) { create(:dosage, dosage_at: 3.days.ago, user: user) }
      it '値が0のグラフデータ、目標値、達成率を取得できること' do
        get api_v1_user_graph_index_path, headers: auth_header
        json = JSON.parse(response.body)
        graph_data = json['graph_data']

        expect(response).to have_http_status(:ok)
        expect(json).to include('graph_data', 'goal', 'achievement_rate')
        expect(graph_data.all? { |data| data['y'].zero? }).to be_truthy
      end
    end
    context '服用記録が存在しない時' do
      it '値が0のグラフデータ、目標値、達成率を取得できること' do
        get api_v1_user_graph_index_path, headers: auth_header
        json = JSON.parse(response.body)
        graph_data = json['graph_data']

        expect(response).to have_http_status(:ok)
        expect(json).to include('graph_data', 'goal', 'achievement_rate')
        expect(graph_data.all? { |data| data['y'].zero? }).to be_truthy
      end
    end
  end
end
