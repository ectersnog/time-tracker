# frozen_string_literal: true

module TimeEntries
  class Show < ApplicationOperation
    # Gets a specific TimeEntry from the database
    #
    # @param params [Hash]
    # @option params [String<UUID>] :id The id of the TimeEntry to have returned
    # @return [Dry::Monads::Result::Success<TimeEntry>>]
    def call(params:)
      step find_time_entry(params[:id])
    end

    private

    def find_time_entry(id)
      time_entry = TimeEntry.find(id)

      Success(time_entry)
    end
  end
end
