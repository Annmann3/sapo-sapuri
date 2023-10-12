class Api::V1::GuestUserGraphController < ApplicationController
  before_action :set_nutrient, only: %i[create]
  before_action :set_amount

  VITAMIN_C_DEFALUT_AMOUNT = 500

  # 現在時刻から２４時間後までのグラフデータ
  def show
    render json: @nutrient.calculate_24hours(@amount)
  end

  # 複数回服用に対応する予定
  def create
    dosage_at = Time.zone.parse(graph_params[:dosage_at])
    render json: @nutrient.calculate_24hours(@amount, dosage_at)
  end

  private

  def set_nutrient
    @nutrient = Nutrient.find(graph_params[:nutrient_id])
  end

  def graph_params
    params.require(:guest_user_graph).permit(:nutrient_id, :dosage_at, :amount)
  end

  def set_amount
    @amount = params[:amount] || VIATMIN_C_DEFALUT_AMOUNT
  end
end
