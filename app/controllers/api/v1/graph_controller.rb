class Api::V1::GraphController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %i[show]
  before_action :set_nutrient, only: %i[draw24]

  def draw24
    amount = params[:dosage] || 500
    render json: @nutrient.calculate_24hours(amount)
  end

  # nutrient_idを受け取り種類別に表示する予定
  def show
    @dosage = current_api_v1_user.dosages.last_dosage
    @nutrient = @dosage.nutrient
    if @dosage.dosage_at > 1.day.ago
      render json: @nutrient.calculate_24hours(@dosage.amount, @dosage.dosage_at)
    else
      render json: @nutrient.calculate_24hours(0)
    end
  end

  private

  def set_nutrient
    @nutrient = Nutrient.find(params[:nutrient_id])
  end
end
