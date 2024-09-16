require "test_helper"

class BestPossibleGainControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get best_possible_gain_show_url
    assert_response :success
  end
end
