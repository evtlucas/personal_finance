# frozen_string_literal: true

class AccountsController < ApplicationController
  def index
    @accounts = Account.order(:name)
  end

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)

    if @account.save
      flash[:notice] = 'Account saved with success'
      redirect_to :accounts
    else
      flash[:notice] = 'Error during account saving process'
      render :new
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])

    if @account.update(account_params)
      flash[:notice] = 'Account updated with success'
      redirect_to :accounts
    else
      flash[:notice] = 'Error during account saving process'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    redirect_to :accounts
  end

  private

  def account_params
    params.require(:account).permit(:name)
  end
end
