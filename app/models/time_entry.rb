# frozen_string_literal: true

# @!attribute [r] created_at
#   When the time entry was created.
#   @return [DateTime]
#
# @!attribute [r] id
#   The id of the current time entry
#   @return [String<UUID>]
#
# @!attribute [rw] line_item_id
#   The line id of the associated line item
#   @return [String<UUID>]
#
# @!attribute [rw] started_at
#   The time that the entry was started
#   @return [DateTime]
#
# @!attribute [rw] stopped_at
#   The time that the entry was stopped at || nil if still running
#   @return [DateTime,nil]
#
# @!attribute [r] updated_at
#   When the time entry was updated
#   @return [DateTime]

class TimeEntry < ApplicationRecord
  belongs_to :line_item

  validates :started_at,
    presence: true
  validates :stopped_at,
    allow_nil: true,
    comparison: { greater_than: :started_at }
  validate :only_one_active_time_entry
  validate :time_entry_not_overlapping

  # The time in seconds of the current time entry
  #   @return [Integer]
  def time_in_seconds
    if stopped_at.nil?
      (Time.current - started_at).to_i
    else
      (stopped_at - started_at).to_i
    end
  end

  # Starts the current time entry
  #   @return [Boolean]
  def start
    return false if started_at.present?

    update(started_at: Time.current)
  end

  # Stops the current time entry
  #   @return [Boolean]
  def stop
    return false if stopped_at.present?

    update(stopped_at: Time.current)
  end

  private

  def only_one_active_time_entry
    return if stopped_at.present?

    scope = line_item.time_entries.where(stopped_at: nil)
    scope = scope.where.not(id:) if persisted?

    return if scope.none?

    errors.add(:stopped_at, message: "Only one active time entry permitted")
  end

  def time_entry_not_overlapping
    return if started_at.nil? || stopped_at.nil?

    overlapping = TimeEntry
      .where(line_item_id:)
      .where.not(id:)
      .exists?(["started_at < ? AND stopped_at > ?", stopped_at, started_at])

    return unless overlapping

    errors.add(:overlapping, "Time entry overlaps with existing time entry")
  end
end
