class PotatoPrice < ApplicationRecord
  validates :time, :value, presence: true
  validates :value, numericality: { greater_than_or_equal_to: 0 }

  MAX_TONNAGE_ALLOWED = 100
end
