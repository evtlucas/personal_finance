require 'rails_helper'

RSpec.describe FinancialRecord, type: :model do
  fixtures :accounts
  fixtures :financial_records

  let(:account) { accounts(:account) }
  subject(:record) { financial_records(:gs1) }

  describe "associations" do
    it { is_expected.to belong_to(:account) }
  end

  it "is valid with attributes" do
    expect(record).to be_valid
  end

  it "is not valid without a description" do
    should validate_presence_of(:description)
  end

  it "is not valid without a value" do
    should validate_presence_of(:value)
  end

  it "is not valid without a category" do
    should validate_presence_of(:category)
  end

  it "is not valid without a record date" do
    should validate_presence_of(:record_date)
  end

  it "is valid when value is greater than zero" do
    expect(financial_records(:income)).to be_valid
  end

  it "is valid when value is lesser than zero" do
    expect(record).to be_valid
  end

  it "is not valid when value is equal to zero" do
    invalid_record = FinancialRecord.new(
      description: 'test',
      value: 0,
      category: 1,
      account: account,
      record_date: 1.days.ago
    )
    expect(invalid_record).to_not be_valid
  end

  it "is not valid when record date is in the future" do
    invalid_record = FinancialRecord.new(
      description: 'test',
      value: -100,
      category: 1,
      account: account,
      record_date: 1.days.since(Time.now)
    )
    expect(invalid_record).to_not be_valid
  end
end