class PotatoPricesController < ApplicationController
  def show
    if price_potato_params[:date].present?
      head :ok
    else
      head :no_content
    end
  end

  private

  def price_potato_params
    params.permit(:date)
  end
end
