# frozen_string_literal: true

json.time_entry do
  json.id time_entry.id
  json.started_at time_entry.started_at
  json.stopped_at time_entry.stopped_at
end
