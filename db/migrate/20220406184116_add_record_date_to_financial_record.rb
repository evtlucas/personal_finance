# frozen_string_literal: true

class AddRecordDateToFinancialRecord < ActiveRecord::Migration[6.1]
  def change
    add_column :financial_records, :record_date, :date, null: false
  end
end
