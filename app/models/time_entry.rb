# frozen_string_literal: true

class TimeEntry < ApplicationRecord
  belongs_to :line_item

  validates :started_at,
    presence: true

  validate :only_one_active_time_entry

  def time_in_seconds
    if stopped_at.nil?
      (Time.current - started_at).to_i
    else
      (stopped_at - started_at).to_i
    end
  end

  private

  def only_one_active_time_entry
    return if stopped_at.present?

    scope = line_item.time_entries.where(stopped_at: nil)
    scope = scope.where.not(id:) if persisted?

    return if scope.none?

    errors.add(:stopped_at, message: "Only one active time entry permitted")
  end
end
