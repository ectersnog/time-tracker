# frozen_string_literal: true

json.time_entries do
  json.partial! 'time_entry', collection: time_entries, as: :time_entry
end
