# frozen_string_literal: true

module TimeEntries
  class Show < ApplicationOperation
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
