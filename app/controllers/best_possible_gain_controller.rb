class BestPossibleGainController < ApplicationController
  def show
    date = price_potato_params[:date]
    prices = PotatoPriceService.prices_for_date(date).pluck(:value)
    max_gain = calculate_max_gain(prices)
    p max_gain.class
    render json: { max_gain: max_gain }
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
