# frozen_string_literal: true

module Schemas
  module Lists
    def self.schema
      {
        list: {
          list: {
            type: :object,
            properties: {
              id: { type: :string,
                format: :uuid,
                example: '123e4567-e89b-12d3-a456-426614174000' },
              name: { type: :string }
            },
            required: %w[id name]
          }
        },
        list_response: {
          type: :object,
          properties: {
            lists: {
              type: :array,
              items: {
                "$ref" => '#components/schemas/list'
              }
            }
          }
        }
      }
    end
  end
end
