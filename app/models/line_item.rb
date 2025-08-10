# frozen_string_literal: true

# @!attribute [r] created_at
#   When the line item was created.
#   @return [DateTime]
#
# @!attribute id
#   The id of the line item
#   @return [String<UUID>]
#
# @!attribute list_id
#   The id of the associated list
#   @return [String<UUID>]
#
# @!attribute [rw] task
#   The name of the line item
#   @return [String]
#
# @!attribute [r] updated_at
#   When the line item was last updated.
#   @return [DateTime]

class LineItem < ApplicationRecord
  belongs_to :list
  has_many :time_entries,
    dependent: :destroy

  validates :task,
    length: { minimum: 4 },
    presence: true,
    uniqueness: true

  # attr_reader :total_time_in_seconds

  # Returns the total time in seconds of time entries belonging to current line item
  #
  # @return [Integer]
  def total_time_in_seconds
    time_entries.sum(&:time_in_seconds)
  end

  # Stops the current running time entry
  #
  # @return [Boolean]
  def stop_running_time_entry
    running = time_entries.where(stopped_at: nil)
    return if running.empty?

    running.first.stop
  end
end
