# frozen_string_literal: true

json.lists do
  json.partial! 'list', collection: lists, as: :list
end
