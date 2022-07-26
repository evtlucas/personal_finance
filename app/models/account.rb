# frozen_string_literal: true

class Account < ApplicationRecord
  validates_presence_of :name
  validates :name, uniqueness: true

  has_many :financial_record

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
