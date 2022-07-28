# frozen_string_literal: true

module MainHelper
  def line_financial_records(value)
    "#{value['description']} - #{value['category']} - #{value['value']}"
  end
end
