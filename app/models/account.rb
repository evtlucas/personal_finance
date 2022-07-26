# frozen_string_literal: true

class Account < ApplicationRecord
  validates_presence_of :name
  validates :name, uniqueness: true

  has_many :financial_record

  scope :total_incomes, -> (account_id) { 
    joins('JOIN financial_records ON financial_records.account_id = accounts.id')
    .where('financial_records.value > 0')
    .where(financial_records: { 'account_id': account_id })
    .sum(:value)
  }

  scope :total_outcomes, -> (account_id) { 
    joins('JOIN financial_records ON financial_records.account_id = accounts.id')
    .where('financial_records.value < 0')
    .where(financial_records: { 'account_id': account_id })
    .sum(:value)
  }

  def total_incomes
    Account.total_incomes(id)
  end

  def total_outcomes
    Account.total_outcomes(id)
  end

  def balance
    total_incomes - (-total_outcomes)
  end

  def as_hash
    return {
      'name': name,
      'outcomes': transform_outcomes
    }
  end

  private

  def transform_outcomes
    financial_record.outcomes.map{ |fr| fr.as_hash }
  end
end
