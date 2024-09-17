module PotatoServices
  class BestPossibleGain
    attr_reader :date

    def initialize(date)
      @date =Date.parse(date)
    end

    def call
      prices = fetch_prices
      prices.present? ? calculate_max_gain(prices) : raise_not_found_error
    end

    private

    def fetch_prices
      PotatoPrice.where(time: date_range).order(:time).pluck(:value)
    end

    def date_range
      date.beginning_of_day..date.end_of_day
    end

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

    def raise_not_found_error
      raise ActiveRecord::RecordNotFound, 'No prices found for the specified date'
    end
  end
end
