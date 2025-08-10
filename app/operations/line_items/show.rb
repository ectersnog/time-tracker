# frozen_string_literal: true

module LineItems
  class Show < ApplicationOperation
    # Gets a specific LineItem from the database
    #
    # @param params [Hash]
    # @option params [String<UUID>] :id The id of the LineItem to have returned
    # @return [Dry::Monads::Result::Success<LineItem>>]
    def call(params:)
      step find_list(params[:id])
    end

    private

    def find_list(id)
      line_item = LineItem.find(id)

      Success(line_item)
    end
  end
end
