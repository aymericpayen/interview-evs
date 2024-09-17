module DateValidation
  extend ActiveSupport::Concern

  private

  def valid_date?(date, format)
    return false if date.nil?
    Date.strptime(date, format)
    true
  rescue ArgumentError
    false
  end
end
