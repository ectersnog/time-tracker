# frozen_string_literal: true

json.deleted do
  json.partial! 'list', list:, as: :list
end
