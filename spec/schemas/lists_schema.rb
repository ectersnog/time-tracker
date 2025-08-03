# frozen_string_literal: true

module Schemas
  module Lists
    def self.schema
      {
        list_response: {
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
        lists_response: {
          type: :object,
          properties: {
            lists: {
              type: :array,
              items: {
                "$ref" => '#components/schemas/list_response'
              }
            }
          }
        },
        list_update: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: ['name']
        },
        deleted_response: {
          type: :object,
          properties: {
            deleted: {
              '$ref' => '#components/schemas/list_response'
            }
          },
          required: ['deleted']
        }
      }
    end
  end
end
