# frozen_string_literal: true

class MainController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @accounts = AccountsSummary.execute
  end
end
