class Api::V1::DosagesController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_dosage, only: %i[update destroy]

  def index
    @dosages = current_api_v1_user.dosages
    render json: @dosages
  end

  def create
    @dosage = current_api_v1_user.dosages.build(dosage_params)

    if @dosage.save
      render_success(@dosage)
    else
      render_error(@dosage)
    end
  end

  def update
    if @dosage.update(dosage_params)
      render_success(@dosage)
    else
      render_error(@dosage)
    end
  end

  def destroy
    @dosage.destroy!
    render_success(@dosage)
  end

  private

  def set_dosage
    @dosage = current_api_v1_user.dosages.find(params[:id])
  end

  def dosage_params
    params.require(:dosage).permit(:amount, :dosage_at, :nutrient_id)
  end
end
