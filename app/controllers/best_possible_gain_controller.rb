class BestPossibleGainController < ApplicationController
  include DateValidation

  def show
    if price_potato_params[:date].present? && valid_date?(price_potato_params[:date], '%Y-%m-%d')
      prices = PotatoPriceService.prices_for_date(price_potato_params[:date]).pluck(:value)
      max_gain = calculate_max_gain(prices)
      render json: { max_gain: max_gain }, status: :ok
    else
      render json: { error: 'Please specify a valid date YYYY-mm-dd' }, status: :unprocessable_content
    end
  end

   private

   def calculate_max_gain(prices)
    return 0 if prices.size < 2

    min_price = prices.first
    max_gain = 0

    prices.each do |price|
      min_price = [min_price, price].min
      potentially_max_gain = price - min_price
      max_gain = [max_gain, potentially_max_gain].max
    end

    max_gain * PotatoPrice::MAX_TONNAGE_ALLOWED

   end

  def price_potato_params
    params.permit(:date)
  end
end
