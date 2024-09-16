class PotatoPricesController < ApplicationController
  def show
    if price_potato_params[:date].present?
      prices = PotatoPriceService.prices_for_date(price_potato_params[:date])
      render json: prices, status: :ok
    else
      render json: { error: 'Please specify a date' }, status: :not_found
    end
  end

  private

  def price_potato_params
    params.permit(:date)
  end
end
