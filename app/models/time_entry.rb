# frozen_string_literal: true

class TimeEntry < ApplicationRecord
  belongs_to :line_item

  validates :started_at,
    presence: true
end
