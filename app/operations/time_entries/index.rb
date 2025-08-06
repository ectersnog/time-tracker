# frozen_string_literal: true

module TimeEntries
  class Index < ApplicationOperation
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
