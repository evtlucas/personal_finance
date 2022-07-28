# frozen_string_literal: true

class FinancialRecordsController < ApplicationController
  before_action :find_account

  def index
    @financial_records = @account.financial_record
  end

  def new; end

  def create
    @financial_record = @account.financial_record.create(financial_record_params)
    redirect_to :account_financial_records
  end

  private

  def find_account
    @account = Account.find(params[:account_id])
  end

  def financial_record_params
    params.require(:financial_record).permit(:record_date, :description, :category, :value)
  end
end
