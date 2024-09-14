require "test_helper"

class PotatoPriceTest < ActiveSupport::TestCase
    test "valid potato price stock" do
    price = PotatoPrice.new(time: Time.now, value: 100.25)
    assert price.valid?
  end

  test "invalid potato price stock with missing date" do
    price = PotatoPrice.new(value: 100.25)
    assert_not price.valid?
  end

  test "invalid potato price stock with missing value" do
    price = PotatoPrice.new(time: Time.now)
    assert_not price.valid?
  end

  test "invalid potato price stock with incorect time format" do
    price = PotatoPrice.new(time: "iamnotadate", value: 100.25)
    assert_not price.valid?
  end

  test "invalid potato price stock with incorect value format" do
    price = PotatoPrice.new(time: Time.now, value: -100.25)
    assert_not price.valid?
  end
end
