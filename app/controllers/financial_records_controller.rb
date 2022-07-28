# frozen_string_literal: true

class FinancialRecordsController < ApplicationController
  before_action :find_account

  def index
    @financial_records = @account.financial_record
  end

  def new
    @financial_record = @account.financial_record.build
  end

  def create
    @financial_record = @account.financial_record.build(financial_record_params)

    if @financial_record.save
      flash[:notice] = "Financial record created"
      redirect_to :account_financial_records
    else
      flash[:notice] = 'Error during financial record saving process'
      render :new
    end
  end

  def edit
    @financial_record = FinancialRecord.find_by(id: params[:id], account: @account)
  end

  def update
    @financial_record = FinancialRecord.find_by(id: params[:id], account: @account)

    if @financial_record.update(financial_record_params)
      flash[:notice] = "Financial record created"
      redirect_to :account_financial_records
    else
      flash[:notice] = 'Error during financial record saving process'
      render :new
    end
  end

  def destroy
    @financial_record = FinancialRecord.find_by(id: params[:id], account: @account)
    @financial_record.destroy

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
