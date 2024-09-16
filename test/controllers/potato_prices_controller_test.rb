require "test_helper"

class PotatoPricesControllerTest < ActionDispatch::IntegrationTest
  test "should return 422 when no params provided" do
    get potato_prices_show_url
    assert_response :unprocessable_content
  end

  test "should return 422 when invalid params provided" do
    get potato_prices_show_url, params: { date: '2022' }
    assert_response :unprocessable_content
  end
  test "should return 204 when params provided does not match any data" do
    get potato_prices_show_url, params: { date: '2022-08-23' }
    assert_response :not_found
  end

  test "should return 404 when params provided but 0 prices found" do
    get potato_prices_show_url, params: { date: '2022-08-22' }
    assert_response :not_found
  end


  test "should return 200 when params provided and match prices" do
    prices = [
      { time: DateTime.new(2024, 9, 13, 9, 0, 0).strftime("%FT%T.%LZ"), value: 100.25 },
      { time: DateTime.new(2024, 9, 13, 9, 1, 0).strftime("%FT%T.%LZ"), value: 100.29 }
    ]
    PotatoPrice.create!(prices)
    get potato_prices_show_url, params: { date: "2024-09-13" }
    assert_response :success
  end
end
