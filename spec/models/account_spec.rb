require 'rails_helper'

RSpec.describe Account, type: :model do
  fixtures :accounts
  
  let(:account) { accounts(:account) }

  describe "associations" do
    it { is_expected.to have_many(:financial_record)}
  end
  
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
