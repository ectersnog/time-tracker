# frozen_string_literal: true

FactoryBot.define do
  factory :time_entry do
    started_at { Time.current }
    stopped_at { 1.hour.from_now }
    line_item
  end
end
