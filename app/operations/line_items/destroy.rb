# frozen_string_literal: true

module LineItems
  class Destroy < ApplicationOperation
    # Destroys a LineItem and associated time entries
    #
    # @param params [Hash]
    # @option params [String<UUID>] :id The id of the LineItem to be destroyed
    # @return [Dry::Monads::Result::Success<LineItem>]
    def call(params:)
      step destroy(params[:id])
    end

    private

    def destroy(id)
      line_item = LineItem.find(id)
      Success(line_item.destroy)
    end
  end
end
