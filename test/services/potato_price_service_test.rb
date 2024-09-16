require 'test_helper'

class PotatoPriceServiceTest < ActionDispatch::IntegrationTest
  test "should get show with params and return 404" do
    assert_raises(ActiveRecord::RecordNotFound) do
      PotatoPriceService.prices_for_date("2024-09-13")
    end
  end

  test "should return prices for a given date is ascending order" do
    prices = [
      { time: DateTime.new(2024, 9, 13, 9, 1, 0).strftime("%FT%T.%LZ"), value: 100.29 }, { time: DateTime.new(2024, 9, 13, 9, 0, 0).strftime("%FT%T.%LZ"), value: 100.25 }

    ]
    PotatoPrice.create!(prices)

    prices = PotatoPriceService.prices_for_date("2024-09-13")

    assert_equal prices.first[:value], 100.25
    assert_equal prices.first[:time], "Fri, 13 Sep 2024 09:00:00.000000000 UTC +00:00"
    assert_equal prices.length, 2
  end
end
