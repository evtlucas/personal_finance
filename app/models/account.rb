# frozen_string_literal: true

class Account < ApplicationRecord
  include ActiveModel::Serialization

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

  def outcomes
    financial_record.outcomes.map(&:as_json)
  end

  def incomes
    financial_record.incomes.map(&:as_json)
  end

  def attributes
    {
      'name' => name,
      'balance' => balance,
      'outcomes' => outcomes,
      'incomes' => incomes
    }
  end
end
