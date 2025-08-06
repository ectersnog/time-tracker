# frozen_string_literal: true

module Schemas
  module LineItems
    def self.schema
      {
        line_item_response: {
          line_item: {
            type: :object,
            properties: {
              id: { type: :string,
                format: :uuid,
                example: '123e4567-e89b-12d3-a456-426614174000' },
              task: { type: :string }
            },
            required: %w[id task]
          }
        },
        line_items_response: {
          type: :object,
          properties: {
            line_items: {
              type: :array,
              items: {
                "$ref" => '#components/schemas/line_item_response'
              }
            }
          }
        },
        line_item_update: {
          type: :object,
          properties: {
            task: { type: :string }
          },
          required: ['task']
        },
        deleted_response: {
          type: :object,
          properties: {
            deleted: {
              '$ref' => '#components/schemas/line_item_response'
            }
          },
          required: ['deleted']
        }
      }
    end
  end
end
