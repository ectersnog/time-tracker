# frozen_string_literal: true

module Schemas
  module Reports
    def self.schema
      {
        line_item_report_response: {
          line_item: {
            type: :object,
            properties: {
              list: { type: :string },
              task: { type: :string },
              duration: { type: :integer }
            },
            required: %w[list task duration]
          }
        },
        report_response: {
          report: {
            type: :object,
            properties: {
              line_items: {
                type: :array,
                items: {
                  "$ref" => '#components/schemas/line_item_report_response'
                }
              }
            }
          }
        },
        reports_params: {
          type: :object,
          properties: {
            start: { type: :string },
            end: { type: :string }
          },
          required: %w[start end]
        }
      }
    end
  end
end
