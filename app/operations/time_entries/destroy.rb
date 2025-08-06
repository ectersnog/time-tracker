# frozen_string_literal: true

module TimeEntries
  class Destroy < ApplicationOperation
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
