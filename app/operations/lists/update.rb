# frozen_string_literal: true

module Lists
  class Update < ApplicationOperation
    # Update a List in the database
    #
    # @param params [Hash]
    # @option params [String<UUID>] :id The id of the List to update
    # @option params [string] :name The name for the List
    # @return [Dry::Monads::Result::Success<List>,Dry::Monads::Result::Failure]
    def call(params:)
      step update_list(params:)
    end

    private

    def update_list(params:)
      list = List.find(params[:id])

      if list.update(name: params[:name])
        Success(list)
      else
        Failure(list.errors.full_messages)
      end
    end
  end
end
