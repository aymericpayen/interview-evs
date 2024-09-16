require "test_helper"

class BestPossibleGainControllerTest < ActionDispatch::IntegrationTest
  test "should return max_gain = 0 when only one price record" do
    PotatoPrice.create!(time: '2022-08-22T09:00:00.000Z', value: 100.25)


    get best_possible_gain_show_url, params: { date: '2022-08-22' }
    p JSON.parse(response.body)
    assert_equal 0, JSON.parse(response.body)['max_gain']
  end
  test 'should return max_gain = 0 when prices does not fluctuate' do
    PotatoPrice.create!(time: '2022-08-22T09:00:00.000Z', value: 100.25)
    PotatoPrice.create!(time: '2022-08-22T09:01:00.000Z', value: 100.25)
    PotatoPrice.create!(time: '2022-08-22T09:02:00.000Z', value: 100.25)
    get best_possible_gain_show_url, params: { date: '2022-08-22' }
    p JSON.parse(response.body)
    assert_equal 0, JSON.parse(response.body)['max_gain']
  end

  test 'should return max_gain = 0 when prices is only decreasing during the day' do
    PotatoPrice.create!(time: '2022-08-22T09:00:00.000Z', value: 100.25)
    PotatoPrice.create!(time: '2022-08-22T09:01:00.000Z', value: 100.24)
    PotatoPrice.create!(time: '2022-08-22T09:02:00.000Z', value: 100.23)
    get best_possible_gain_show_url, params: { date: '2022-08-22' }
    p JSON.parse(response.body)
    assert_equal 0, JSON.parse(response.body)['max_gain']
  end

  test 'should return max_gain = 6 when prices fluctuates positively during the day' do
    PotatoPrice.create!(time: '2022-08-22T09:00:00.000Z', value: 100.25)
    PotatoPrice.create!(time: '2022-08-22T09:01:00.000Z', value: 100.29)
    PotatoPrice.create!(time: '2022-08-22T09:02:00.000Z', value: 100.31)
    get best_possible_gain_show_url, params: { date: '2022-08-22' }
    p JSON.parse(response.body)
    assert_equal "6.0", JSON.parse(response.body)['max_gain']
  end
end
