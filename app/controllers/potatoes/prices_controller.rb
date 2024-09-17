module Potatoes
  class PricesController < ApplicationController
    include DateValidation

    def show
      if valid_date?(price_potato_params[:date], '%Y-%m-%d')
        begin
          service =  PotatoServices::Prices.new(price_potato_params[:date])
          prices = service.call
          render json: prices, status: :ok
        rescue ActiveRecord::RecordNotFound => e
          render json: {error: e.message}, status: :not_found
        end
      else
        render json: { error: 'Please specify a valid date YYYY-mm-dd' }, status: :unprocessable_content
      end
    end

    private

    def price_potato_params
      params.permit(:date)
    end
  end
end
