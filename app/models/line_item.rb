# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :list
  has_many :time_entries,
    dependent: :destroy

  validates :task,
    presence: true,
    length: { minimum: 4 }

  attr_reader :total_time_in_seconds

  def total_time_in_seconds
    time_entries.sum(&:time_in_seconds)
  end

  def stop_running_time_entry
    running = time_entries.where(stopped_at: nil)
    return if running.empty?

    running.first.stop
  end
end
