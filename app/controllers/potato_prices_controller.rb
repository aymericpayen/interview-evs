class PotatoPricesController < ApplicationController
  def show
    if price_potato_params[:date].present?
      date = Date.parse(price_potato_params[:date])
      prices = prices_for_date(date)
      render json: prices, status: :ok
    else
      render json: { error: 'Please specify a date' }, status: :not_found
    end
  end

  private

  def price_potato_params
    params.permit(:date)
  end

  def prices_for_date(date)
    prices = PotatoPrice.where(time: date.beginning_of_day..date.end_of_day).order(:time)
    if prices.any?
      prices
    else
      raise ActiveRecord::RecordNotFound, 'No prices found for the specified date'
    end
  end
end
