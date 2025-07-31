# frozen_string_literal: true

FactoryBot.define do
  factory :list do
    name { FFaker::Lorem.word }
  end
end
