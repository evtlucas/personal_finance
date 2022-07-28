# frozen_string_literal: true

class MainController < ApplicationController
  def index
    @accounts = AccountsSummary.execute
  end
end
