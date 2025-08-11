# frozen_string_literal: true

module Lists
  class Destroy < ApplicationOperation
    # Destroys a List and associated time entries
    #
    # @param params [Hash]
    # @option params [String<UUID>] :id The id of the List to be destroyed
    # @return [Dry::Monads::Result::Success<LineItem>]
    def call(params:)
      step destroy(params[:id])
    end

    private

    def destroy(id)
      list = List.find(id)
      Success(list.destroy)
    end
  end
end
