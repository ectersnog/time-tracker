# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :list
  has_many :time_entries,
    dependent: :destroy

  validates :task, presence: true
end
