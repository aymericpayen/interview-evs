class PotatoPriceService
  class << self
    def prices_for_date(date)
      date = Date.parse(date)
      prices = PotatoPrice.where(time: date.beginning_of_day..date.end_of_day).order(:time)
      if prices.any?
        prices
      else
        raise ActiveRecord::RecordNotFound, 'No prices found for the specified date'
      end
    end
  end
end
