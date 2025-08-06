# frozen_string_literal: true

module LineItems
  class Index < ApplicationOperation
    def call
      step index
    end

    private

    def index
      line_item = LineItem.all
      Success(line_item)
    end
  end
end
