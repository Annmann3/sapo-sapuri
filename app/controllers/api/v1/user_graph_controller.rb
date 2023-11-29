class Api::V1::UserGraphController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %i[index]

  def index
    dosages = current_api_v1_user.dosages.in_week_asc

    if dosages.blank?
      render json: {
        graph_data: Nutrient.find(1).calculate_zero,
        goal: Nutrient.find(1).calculate_goal(nil),
        achievement_rate: Dosage.weekly_achievement_rate(current_api_v1_user)
      }
    else
      render json: {
        graph_data: Nutrient.find(1).calculate_combined_24hours(dosages),
        goal: Nutrient.find(1).calculate_goal(dosages.last_dosage),
        achievement_rate: Dosage.weekly_achievement_rate(current_api_v1_user)
      }
    end
  end
end
