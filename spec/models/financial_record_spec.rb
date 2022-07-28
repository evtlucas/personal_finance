# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FinancialRecord, type: :model do
  fixtures :accounts
  fixtures :financial_records

  subject(:record) { financial_records(:gs1) }

  let(:account) { accounts(:account) }

  describe 'associations' do
    it { is_expected.to belong_to(:account) }
  end

  describe 'is valid with' do
    it 'attributes' do
      expect(record).to be_valid
    end
  end

  describe 'is valid when value is' do
    it 'greater than zero' do
      expect(financial_records(:income)).to be_valid
    end

    it 'lesser than zero' do
      expect(record).to be_valid
    end
  end

  describe 'is not valid without' do
    it 'a description' do
      is_expected.to validate_presence_of(:description)
    end

    it 'a value' do
      is_expected.to validate_presence_of(:value)
    end

    it 'a category' do
      is_expected.to validate_presence_of(:category)
    end

    it 'a record date' do
      is_expected.to validate_presence_of(:record_date)
    end
  end

  describe 'is not valid when' do
    it 'value is equal to zero' do
      invalid_record = described_class.new(
        description: 'test',
        value: 0,
        category: 'grocery_store',
        account:,
        record_date: 1.days.ago
      )
      expect(invalid_record).not_to be_valid
    end

    it 'record date is in the future' do
      invalid_record = described_class.new(
        description: 'test',
        value: -100,
        category: 'grocery_store',
        account:,
        record_date: 1.days.since(Time.now)
      )
      expect(invalid_record).not_to be_valid
    end
  end

  describe '#as_hash' do
    subject(:record_content) { record.as_json }

    it 'assesses the content of the hash' do
      expect(record_content['description']).to eql(record.description)
      expect(record_content['value']).to eql(record.value.to_s)
      expect(record_content['category']).to eql(record.category)
      expect(record_content['record_date']).to eql(record.record_date.to_s)
    end
  end
end
