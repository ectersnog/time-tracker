# frozen_string_literal: true

module TimeEntries
  class Update < ApplicationOperation
    def call(params:)
      step update_time_entry(params:)
    end

    private

    def update_time_entry(params:)
      time_entry = TimeEntry.find(params[:id])
      started_at = parse_time_entry(params[:started_at])
      stopped_at = parse_time_entry(params[:stopped_at])

      permitted_attrs = {
        started_at:,
        stopped_at:,
        id: time_entry.id
      }.compact

      if time_entry.update(permitted_attrs)
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
