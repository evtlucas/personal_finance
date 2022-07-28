# frozen_string_literal: true

class CreateFinancialRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :financial_records do |t|
      t.text :description, null: false
      t.decimal :value, null: false
      t.string :category, null: false, default: 'dwelling'
      t.references :account, null: false, foreign_key: true

      t.timestamps
    end
  end
end
