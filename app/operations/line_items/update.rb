# frozen_string_literal: true

module LineItems
  class Update < ApplicationOperation
    # Update a LineItem in the database
    #
    # @param params [Hash]
    # @option params [String<UUID>] :id The id of the LineItem to update
    # @option params [String<UUID>] :list_id The List that LineItem is associated with
    # @option params [string] :task The name of the task for the LineItem
    # @return [Dry::Monads::Result::Success<LineItem>,Dry::Monads::Result::Failure]
    def call(params:)
      step update_list(params:)
    end

    private

    def update_list(params:)
      line_item = LineItem.find(params[:id])

      if line_item.update(task: params[:task])
        Success(line_item)
      else
        Failure(line_item.errors.full_messages)
      end
    end
  end
end
