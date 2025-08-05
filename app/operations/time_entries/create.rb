# frozen_string_literal: true

module TimeEntries
  class Create < ApplicationOperation
    def call(params:)
      step create_time_entry(params:)
    end

    private

    def create_time_entry(params:)
      line_item = LineItem.find(params[:line_item])

      started_at = parse_time_entry(params[:started_at])
      stopped_at = parse_time_entry(params[:stopped_at])

      permitted_attrs = {
        started_at:,
        stopped_at:,
        line_item:
      }.compact

      time_entry = TimeEntry.new(permitted_attrs)

      if time_entry.save
        Success(time_entry)
      else
        Failure(time_entry.errors.full_messages)
      end
    end

    def parse_time_entry(str)
      return str if str.is_a?(Time)
      return nil if str.blank?

      Time.zone.parse(str)
    rescue ArgumentError
      nil
    end
  end
end
