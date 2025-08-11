# frozen_string_literal: true

json.report do
  json.partial! 'line_item', collection: report, as: :line_item
end
