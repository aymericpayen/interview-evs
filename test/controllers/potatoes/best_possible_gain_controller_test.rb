require "test_helper"

class Potatoes::BestPossibleGainControllerTest < ActionDispatch::IntegrationTest
  test "should return 422 when no params provided" do
    get potatoes_best_possible_gain_path, params: { date: '08-22' }
    assert_response :unprocessable_content
    assert_equal "Please specify a valid date YYYY-mm-dd", JSON.parse(response.body)["error"]
  end

    test "should return 204 when invalid params provided" do
    PotatoPrice.create!(time: '2022-08-22T09:00:00.000Z', value: 100.25)
    get potatoes_best_possible_gain_path , params: { date: '2022-08-23' }
    assert_response :not_found
    assert_equal "No prices found for the specified date", JSON.parse(response.body)["error"]
  end


  test "should return 200 and max_gain = 0 when only one price record" do
    PotatoPrice.create!(time: '2022-08-22T09:00:00.000Z', value: 100.25)
    get potatoes_best_possible_gain_path, params: { date: '2022-08-22' }
    assert_response :success
    assert_equal 0, JSON.parse(response.body)['max_gain']
  end

  test 'should return 200 and max_gain = 6 when prices fluctuates positively during the day' do
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 0, 0).strftime("%FT%T.%LZ"), value: 100.25)
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 1, 0).strftime("%FT%T.%LZ"), value: 100.29)
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 2, 0).strftime("%FT%T.%LZ"), value: 100.31)
    get potatoes_best_possible_gain_path, params: { date: '2022-08-22' }
    assert_response :success
    assert_equal "6.0", JSON.parse(response.body)['max_gain']
  end
end
