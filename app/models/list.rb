# frozen_string_literal: true

class List < ApplicationRecord
  has_many :line_items,
    dependent: :destroy

  validates :name,
    length: { minimum: 4, maximum: 20 },
    presence: true
end
