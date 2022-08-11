class Api::V1::NutrientsController < ApplicationController
  before_action :set_nutrient, only: %i[show graph]
  def index
    @nutrients = Nutrient.all
    render json: @nutrients
  end

  def create
    @nutrient = Nutrient.new(nutrient_params)
    if @nutrient.save
      render json: @nutrien
    else
      render json: @nutrient.errors
    end
  end

  def new
  end

  def edit
  end

  def show
    render json: @nutrient
  end

  def update
  end

  def destroy
  end

  private

  def set_nutrient
    @nutrient = Nutrient.find(params[:id])
  end

  def nutrient_params
    params.require(:nutrient).permit(:name, :graph_constant, :graph_type, :dosage_recommendation)
  end
end
