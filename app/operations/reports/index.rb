# frozen_string_literal: true

module Reports
  class Index < ApplicationOperation
    def call(params:)
      step get_items(params:)
    end

    private

    def get_items(params:)
      start_time = Time.zone.parse(params[:start])
      end_time = Time.zone.parse(params[:end])

      result = LineItem
        .joins(:time_entries)
        .select(
          'line_items.*, SUM(EXTRACT(EPOCH FROM (time_entries.stopped_at - time_entries.started_at))) AS total_time_seconds'
        )
        .group('line_items.id')

      Success(result)

    end
  end
end
