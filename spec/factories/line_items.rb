# frozen_string_literal: true

FactoryBot.define do
  factory :line_item do
    list
    task { FFaker::Lorem.characters(10) }
  end
end
