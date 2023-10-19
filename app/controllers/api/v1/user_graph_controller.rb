class Api::V1::UserGraphController < ApplicationController
  before_action :authenticate_api_v1_user!, only: %i[index]

  # 24時間以内の最後に服用したサプリのグラフデータ
  # 複数のサプリメントを取得できるようにする予定
  def index
    dosage = current_api_v1_user.dosages.last_dosage

    if dosage.blank? || dosage.dosage_at <= 24.hours.ago
      render json: Nutrient.find(1).calculate_zero
    else
      render json: Nutrient.find(1).calculate_24hours(dosage.amount, dosage.dosage_at)
    end
  end
end
