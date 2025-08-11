# frozen_string_literal: true

json.deleted do
  json.partial! 'line_item', line_item:, as: :line_item
end
