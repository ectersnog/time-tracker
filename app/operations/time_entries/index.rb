# frozen_string_literal: true

module TimeEntries
  class Index < ApplicationOperation
    # Gets a list of all TimeEntries
    #
    # @return [Dry::Monads::Result::Success<ActiveRecord::Relation<TimeEntry>>]
    def call
      step index
    end

    private

    def index
      time_entries = TimeEntry.all
      Success(time_entries)
    end
  end
end
