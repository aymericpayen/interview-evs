class PotatoPricesController < ApplicationController
  include DateValidation

  def show
    if price_potato_params[:date].present? && valid_date?(price_potato_params[:date], '%Y-%m-%d')
      prices = PotatoPriceService.prices_for_date(price_potato_params[:date])
      render json: prices, status: :ok
    else
      render json: { error: 'Please specify a valid date YYYY-mm-dd' }, status: :unprocessable_content
    end
  end

  private

  def price_potato_params
    params.permit(:date)
  end
end
