# frozen_string_literal: true

module TimeEntries
  class Destroy < ApplicationOperation
    # Destroys a TimeEntry
    #
    # @param params [Hash]
    # @option params [String<UUID>] :id The id of the TimeEntry to be destroyed
    # @return [Dry::Monads::Result::Success<TimeEntry>]
    def call(params:)
      step destroy(params[:id])
    end

    private

    def destroy(id)
      time_entry = TimeEntry.find(id)
      Success(time_entry.destroy)
    end
  end
end
