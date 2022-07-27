# frozen_string_literal: true

class Account < ApplicationRecord
  validates_presence_of :name
  validates :name, uniqueness: true

  has_many :financial_record

  def total_incomes
    financial_record.incomes.sum(:value)
  end

  def total_outcomes
    financial_record.outcomes.sum(:value)
  end

  def balance
    total_incomes - (-total_outcomes)
  end

  def as_hash
    return {
      'name': name,
      'balance': balance,
      'outcomes': transform_outcomes,
      'incomes': transform_incomes
    }
  end

  private

  def transform_outcomes
    financial_record.outcomes.map(&:as_hash)
  end

  def transform_incomes
    financial_record.incomes.map(&:as_hash)
  end
end
