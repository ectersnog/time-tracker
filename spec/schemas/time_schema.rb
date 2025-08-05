# frozen_string_literal: true

module Schemas
  module TimeEntries
    def self.schema
      {
        time_entry_response: {
          time_entry: {
            type: :object,
            properties: {
              id: { type: :string,
                format: :uuid,
                example: '123e4567-e89b-12d3-a456-426614174000' },
              started_at: {
                type: :string,
                format: 'date-time'
              },
              stopped_at: {
                type: :string,
                format: 'date-time'
              }
            },
            required: %w[id started_at stopped_at]
          }
        },
        time_entries_response: {
          type: :object,
          properties: {
            time_entries: {
              type: :array,
              items: {
                "$ref" => '#components/schemas/time_entry_response'
              }
            }
          }
        },
        time_entry_update: {
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
              '$ref' => '#components/schemas/time_entry_response'
            }
          },
          required: ['deleted']
        }
      }
    end
  end
end
