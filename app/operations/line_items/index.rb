# frozen_string_literal: true

module LineItems
  class Index < ApplicationOperation
    # Gets a list of all LineItems
    #
    # @return [Dry::Monads::Result::Success<ActiveRecord::Relation<LineItem>>]
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
