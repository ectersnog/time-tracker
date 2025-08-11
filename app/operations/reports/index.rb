# frozen_string_literal: true

module Reports
  class Index < ApplicationOperation
    # Generate a report that groups all TimeEntries by LineItem and List
    #
    # @param params [Hash]
    # @option params [DateTime] :start The time and date you want the report to start
    # @option params [DateTime] :end The time and date you want the report to end
    # @return [Array<Hash>] Contains List, LineItem, and duration for each group
    def call(params:)
      step get_items(params:)
    end

    private

    def get_items(params:)
      start_time = Time.zone.parse(params[:start])
      end_time = Time.zone.parse(params[:end])

      result = LineItem
        .joins(:time_entries)
        .where('time_entries.started_at <= ? AND time_entries.stopped_at >= ?', end_time, start_time)
        .select(
          'line_items.*, SUM(EXTRACT(EPOCH FROM (time_entries.stopped_at - time_entries.started_at)))::bigint AS total_time_seconds'
        )
        .group('line_items.id')

      Success(result)
    end
  end
end
