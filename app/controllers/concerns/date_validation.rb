module DateValidation
  extend ActiveSupport::Concern

  private

  def valid_date?(date, format)
    Date.strptime(date, format)
    true
  rescue ArgumentError
    false
  end
end
