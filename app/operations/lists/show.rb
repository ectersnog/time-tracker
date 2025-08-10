# frozen_string_literal: true

module Lists
  class Show < ApplicationOperation
    # Gets a specific List from the database
    #
    # @param params [Hash]
    # @option params [String<UUID>] :id The id of the List to have returned
    # @return [Dry::Monads::Result::Success<List>>]
    def call(params:)
      step find_list(params[:id])
    end

    private

    def find_list(id)
      list = List.find(id)

      Success(list)
    end
  end
end
