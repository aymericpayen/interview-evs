module PotatoServices
  class Prices
    attr_reader :date

    def initialize(date)
      @date = Date.parse(date)
    end

    def call
      prices = fetch_prices
      prices.present? ? prices : raise_not_found_error
    end

    private

    def fetch_prices
      PotatoPrice.where(time: date_range).order(:time)
    end

    def date_range
      date.beginning_of_day..date.end_of_day
    end

    def raise_not_found_error
      raise ActiveRecord::RecordNotFound, 'No prices found for the specified date'
    end
  end
end
