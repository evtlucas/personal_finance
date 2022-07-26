require 'rails_helper'

RSpec.describe AccountsSummary do
  fixtures :accounts

  subject(:accounts_summary) { AccountsSummary.execute }

  describe "validations" do
    it "validates the content of the account list" do
      expect(accounts_summary.bsearch{|x| x[:name] == accounts[0].name}).to include(name: accounts[0].name)
      expect(accounts_summary.bsearch{|x| x[:name] == accounts[0].name}).to include(balance: accounts[0].balance)
      expect(accounts_summary.bsearch{|x| x[:name] == accounts[0].name}).to have_key(:outcomes)
      expect(accounts_summary.bsearch{|x| x[:name] == accounts[0].name}).to have_key(:incomes)
    end
  end
end