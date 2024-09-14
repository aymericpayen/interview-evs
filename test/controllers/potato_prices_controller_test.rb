require "test_helper"

class PotatoPricesControllerTest < ActionDispatch::IntegrationTest
test "should get show without params and return 204" do
    get potato_prices_show_url
    assert_response :no_content
  end

  test "should get show with paramsa and return 200" do
    get potato_prices_show_url, params: { date: '2022-08-22' }
    assert_response :success
  end
end
