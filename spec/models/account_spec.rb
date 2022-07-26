require 'rails_helper'

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
      expect(account.total_incomes).to be_equal(1000)
    end

    it "should calculate the total of outcomes" do
      expect(account.total_outcomes).to be_equal(-181.28)
    end

    it "should calculate the balance" do
      expect(account.balance).to be_equal(818.72)
    end
  end

  describe "#as_hash" do
    subject(:account_content) { account.as_hash }

    it "assesses the content of the hash" do
      expect(account_content).to include(name: account.name)
      expect(account_content).to include(balance: account.balance)
      expect(account_content).to include(outcomes: account.financial_record.outcomes.map{ |fr| fr.as_hash })
      expect(account_content).to include(incomes: account.financial_record.incomes.map{ |fr| fr.as_hash })
    end
  end
end
