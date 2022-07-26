class AccountsSummary
  def self.execute
    new.execute
  end

  def execute
    accounts = []
    Account.all.each do |account|
      accounts << account.outcomes_as_hash
    end
    accounts
  end
end