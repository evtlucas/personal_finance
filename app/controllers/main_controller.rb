class MainController < ApplicationController
  def index
    @accounts = AccountsSummary.execute
  end
end