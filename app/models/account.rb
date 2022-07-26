# frozen_string_literal: true

class Account < ApplicationRecord
  validates_presence_of :name
  validates :name, uniqueness: true

  has_many :financial_record

  scope :incomes, -> (account_id) { 
    joins('JOIN financial_records ON financial_records.account_id = accounts.id')
    .where('financial_records.value > 0')
    .where(financial_records: { 'account_id': account_id })
    .sum(:value)
  }

  scope :outcomes, -> (account_id) { 
    joins('JOIN financial_records ON financial_records.account_id = accounts.id')
    .where('financial_records.value < 0')
    .where(financial_records: { 'account_id': account_id })
    .sum(:value)
  }

  def total_incomes
    Account.incomes(id)
  end

  def total_outcomes
    Account.outcomes(id)
  end

  def balance
    total_incomes - (-total_outcomes)
  end

  def outcomes_as_hash
    return {
      'account': name,
      'outcomes': transform_outcomes
    }
  end

  private

  def transform_outcomes
    financial_record.select{ |fr| fr.value < 0 }.map{ |fr|
      {
        'description': fr.description,
        'category': fr.category,
        'value': fr.value
      }
    }
  end
end
