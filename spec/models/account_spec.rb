require 'rails_helper'
require 'bigdecimal'

RSpec.describe Account, type: :model do
  fixtures :accounts
  fixtures :financial_records
  
  subject(:account) { accounts(:account) }

  describe "associations" do
    it { is_expected.to have_many(:financial_record)}
  end
  
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe "calculations" do
    it "should calculate the total of incomes" do
      expect(account.total_incomes).to eql(BigDecimal("1000"))
    end

    it "should calculate the total of outcomes" do
      expect(account.total_outcomes).to eql(BigDecimal("-181.28"))
    end

    it "should calculate the balance" do
      expect(account.balance).to eql(BigDecimal("818.72"))
    end
  end

  describe "#as_hash" do
    subject(:account_content) { account.as_json }

    it "assesses the content of the hash" do
      expect(account_content['name']).to eql(account.name)
      expect(account_content['balance']).to eql(account.balance.to_s)
      expect(account_content['outcomes']).to match_array(account.financial_record.outcomes.map{ |fr| fr.as_json })
      expect(account_content['incomes']).to match_array(account.financial_record.incomes.map{ |fr| fr.as_json })
    end
  end
end
