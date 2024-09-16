require "test_helper"

class PotatoPricesControllerTest < ActionDispatch::IntegrationTest
test "should get show without params and return 204" do
    get potato_prices_show_url
    assert_response :not_found
  end

  test "should get show with paramsa and return 200" do
    get potato_prices_show_url, params: { date: '2022-08-22' }
    assert_response :not_found
  end

  test "should return prices for a given date" do
  prices = [
    { time: DateTime.new(2024, 9, 13, 9, 0, 0).strftime("%FT%T.%LZ"), value: 100.25 },
    { time: DateTime.new(2024, 9, 13, 9, 1, 0).strftime("%FT%T.%LZ"), value: 100.29 }
  ]
  PotatoPrice.create!(prices)

  get potato_prices_show_url, params: { date: "2024-09-13" }

  assert_response :success
  assert_equal prices.first[:value], JSON.parse(response.body).first["value"].to_d
  assert_equal prices.first[:time], JSON.parse(response.body).first["time"]
  assert_equal prices.length, JSON.parse(response.body).length
end
end
