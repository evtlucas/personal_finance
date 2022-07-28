# frozen_string_literal: true

class AccountsSummary
  def self.execute
    new.execute
  end

  def execute
    accounts = []
    Account.all.each do |account|
      accounts << account.as_json
    end
    accounts
  end
end
