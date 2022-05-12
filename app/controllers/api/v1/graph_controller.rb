class Api::V1::GraphController < ApplicationController
  before_action :set_nutrient, only: %i[show]
  def show
    constant = @nutrient.graph_constant
    type = @nutrient.graph_type
    constant = @nutrient.graph_constant

    nutrient_graph = `python app/controllers/api/v1/graph_cariculator.py #{type} #{constant}`
    byebug
    render json: @nutrient
  end

  private

  def set_nutrient
    @nutrient = Nutrient.find(params[:id])
  end
end
