class Api::V1::GraphController < ApplicationController
  before_action :set_nutrient, only: %i[show graph]
  def show
    dosage = 500
    render json: @nutrient.calculate_24hours(dosage)
  end

  private

  def set_nutrient
    @nutrient = Nutrient.find(params[:id])
  end

end
