require 'test_helper'

class PotatoServices::BestPossibleGainTest < ActionDispatch::IntegrationTest

  test "raises RecordNotFound when no prices exist for the given date" do
    assert_raises(ActiveRecord::RecordNotFound) do
      service= PotatoServices::BestPossibleGain.new("2024-09-13")
      service.call
    end
  end

  test "returns 0 as best possible gain when prices does not fluctuate" do
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 0, 0).strftime("%FT%T.%LZ"), value: 100.25)
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 1, 0).strftime("%FT%T.%LZ"), value: 100.25)
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 2, 0).strftime("%FT%T.%LZ"), value: 100.25)

    service= PotatoServices::BestPossibleGain.new("2022-08-22")
    best_possible_gain = service.call

    assert_equal 0, best_possible_gain
  end

  test "returns 0 as best possible gain when prices is only decreasing during the day" do
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 0, 0).strftime("%FT%T.%LZ"), value: 100.25)
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 1, 0).strftime("%FT%T.%LZ"), value: 100.24)
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 2, 0).strftime("%FT%T.%LZ"), value: 100.23)


    service= PotatoServices::BestPossibleGain.new("2022-08-22")
    best_possible_gain = service.call

    assert_equal 0, best_possible_gain
  end

  test "returns 6 as best possible gain when when prices fluctuates positively during the day" do
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 0, 0).strftime("%FT%T.%LZ"), value: 100.25)
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 1, 0).strftime("%FT%T.%LZ"), value: 100.29)
    PotatoPrice.create!(time: DateTime.new(2022, 8, 22, 9, 2, 0).strftime("%FT%T.%LZ"), value: 100.31)

    service= PotatoServices::BestPossibleGain.new("2022-08-22")
    best_possible_gain = service.call

    assert_equal "6.0", best_possible_gain.to_s
  end

  test "raises ActiveRecord::RecordNotFound when no prices is found for the specified day" do
    PotatoPrice.create!(time: '2022-08-22T09:00:00.000Z', value: 100.25)

    assert_raise(ActiveRecord::RecordNotFound) do
      service = PotatoServices::BestPossibleGain.new("2022-08-23")
      service.call
    end
  end
end
