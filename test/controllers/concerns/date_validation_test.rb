require 'test_helper'

class DateValidationTest < ActiveSupport::TestCase
  include DateValidation

  test 'returns true for a valid date string' do
    assert valid_date?('2022-08-22', '%Y-%m-%d')
  end

  test 'returns false for an invalid date string' do
    refute valid_date?('2022', '%Y-%m-%d')
  end
end
