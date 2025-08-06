# frozen_string_literal: true

json.deleted do
  json.partial! 'time_entry', time_entry:, as: :time_entry
end
