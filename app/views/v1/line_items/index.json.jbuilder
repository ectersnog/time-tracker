# frozen_string_literal: true

json.line_items do
  json.partial! 'line_item', collection: line_items, as: :line_item
end
