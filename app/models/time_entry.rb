# frozen_string_literal: true

class TimeEntry < ApplicationRecord
  belongs_to :line_item

  validates :started_at,
    presence: true

  validate :only_one_active_time_entry
  validate :started_at_before_stopped_at
  validate :time_entry_not_overlapping

  def time_in_seconds
    if stopped_at.nil?
      (Time.current - started_at).to_i
    else
      (stopped_at - started_at).to_i
    end
  end

  def start
    return false if started_at.present?

    self.started_at = Time.current
    save
  end

  def stop
    return false if stopped_at.present?

    self.stopped_at = Time.current
    save
  end

  private

  def only_one_active_time_entry
    return if stopped_at.present?

    scope = line_item.time_entries.where(stopped_at: nil)
    scope = scope.where.not(id:) if persisted?

    return if scope.none?

    errors.add(:stopped_at, message: "Only one active time entry permitted")
  end

  def started_at_before_stopped_at
    return if started_at.nil? || stopped_at.nil? # Rails apparently sometimes runs this before validating presence of started_at
    return if stopped_at > started_at

    errors.add(:stopped_at, message: "Started at must be before the stopped_at")
  end

  def time_entry_not_overlapping
    return if started_at.nil? || stopped_at.nil?

    overlapping = TimeEntry
      .where(line_item_id:)
      .where.not(id:)
      .exists?(
        ["(started_at <= :start AND stopped_at > :start)",
         { start: started_at }])

    return unless overlapping

    errors.add(:overlapping, "Time entry overlaps with existing time entry")
  end
end
