# frozen_string_literal: true

# @!attribute [r] created_at
#   When the list was created.
#   @return [DateTime]
#
# @!attribute [r] id
#   The uuid of the list
#   @return [String<UUID>]
#
# @!attribute [rw] name
#   The name of the list
#   @return [String]
#
# @!attribute [r] updated_at
#   When the list was last updated.
#   @return [DateTime]

class List < ApplicationRecord
  has_many :line_items,
    dependent: :destroy

  validates :name,
    length: { minimum: 4, maximum: 20 },
    presence: true,
    uniqueness: true
end
