# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :list
  has_many :time_entries,
    dependent: :destroy

  validates :task,
    presence: true,
    length: { minimum: 4 }

  def total_time_in_seconds
    time_entries.sum(&:time_in_seconds)
  end
end
