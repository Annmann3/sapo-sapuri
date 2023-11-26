class Api::V1::UserGraphController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %i[index]

  # 24時間以内の服用したサプリのグラフデータ
  def index
    dosages = current_api_v1_user.dosages.in_24hours

    if dosages.blank?
      render json: Nutrient.find(1).calculate_zero
    else
      render json: {
        graph_data: Nutrient.find(1).calculate_combined_24hours(dosages),
        goal: Nutrient.find(1).calculate_goal(dosages.last_dosage),
        achievement_rate: Dosage.weekly_achievement_rate(current_api_v1_user)
      }
    end
  end
end
