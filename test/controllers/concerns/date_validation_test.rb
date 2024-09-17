require 'test_helper'

class DateValidationTest < ActiveSupport::TestCase
  include DateValidation

  test 'returns true when valid date string' do
    assert valid_date?('2022-08-22', '%Y-%m-%d')
  end

  test 'returns false when invalid date string' do
    refute valid_date?('2022', '%Y-%m-%d')
  end

   test 'returns false when empty date string' do
    refute valid_date?('', '%Y-%m-%d')
  end
end
