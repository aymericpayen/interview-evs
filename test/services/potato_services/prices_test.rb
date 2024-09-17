require 'test_helper'

class PotatoServices::PricesTest < ActionDispatch::IntegrationTest

  test "raises RecordNotFound when no prices exist for the given date" do
    assert_raises(ActiveRecord::RecordNotFound) do
      service= PotatoServices::Prices.new("2024-09-13")
      service.call
    end
  end

  test "returns prices in ascending order by time when prices exist for the given date" do
    prices = [
      { time: DateTime.new(2024, 9, 13, 9, 1, 0).strftime("%FT%T.%LZ"), value: 100.29 }, { time: DateTime.new(2024, 9, 13, 9, 0, 0).strftime("%FT%T.%LZ"), value: 100.25 }

    ]
    PotatoPrice.create!(prices)

    service= PotatoServices::Prices.new("2024-09-13")
    prices = service.call

    assert_equal prices.first[:value], 100.25
    assert_equal prices.first[:time], "Fri, 13 Sep 2024 09:00:00.000000000 UTC +00:00"
    assert_equal prices.length, 2
  end

    test "only returns prices for the specified date when prices exist for the given date" do
    prices = [
      { time: DateTime.new(2024, 9, 13, 9, 1, 0).strftime("%FT%T.%LZ"), value: 100.29 }, { time: DateTime.new(2024, 9, 14, 9, 0, 0).strftime("%FT%T.%LZ"), value: 100.25 }

    ]
    PotatoPrice.create!(prices)

    service= PotatoServices::Prices.new("2024-09-13")
    prices = service.call

    assert_equal prices.first[:time], "Fri, 13 Sep 2024 09:01:00.000000000 UTC +00:00"
    assert_equal prices.length, 1
  end
end
