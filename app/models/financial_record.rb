# frozen_string_literal: true

class FinancialRecord < ApplicationRecord
  belongs_to :account
  validates_presence_of :description
  validates_presence_of :value
  validates_presence_of :category
  validates_presence_of :record_date
  validate :record_date_must_be_registered_today_or_in_the_past

  enum category: {
    dwelling: 0,
    grocery_store: 1,
    restaurant: 2,
    clothes: 3,
    communications: 4,
    leisure: 5,
    pets: 6,
    transport: 7,
    social: 8,
    professionals: 9,
    personal: 10,
    finance: 11,
    education: 12
  }

  private

  def record_date_must_be_registered_today_or_in_the_past
    if record_date.present? && record_date > Date.today
      errors.add(:record_date, "can't be in the future")
    end
  end
end