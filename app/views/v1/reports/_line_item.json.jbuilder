# frozen_string_literal: true

json.line_items do
  json.list line_item.list.name
  json.task line_item.task
  json.duration line_item.total_time_in_seconds
end
