module Potatoes
  class BestPossibleGainController < ApplicationController
    include DateValidation

    def show
      if valid_date?(best_possible_gain_params[:date], '%Y-%m-%d')
        begin
          service = PotatoServices::BestPossibleGain.new(best_possible_gain_params[:date])
          best_possible_gain = service.call
          render json: { max_gain: best_possible_gain }, status: :ok
        rescue ActiveRecord::RecordNotFound => e
          render json: {error: e.message}, status: :not_found
        end
      else
        render json: { error: 'Please specify a valid date YYYY-mm-dd' }, status: :unprocessable_content
      end
    end

     private

    def best_possible_gain_params
      params.permit(:date)
    end
  end
end
