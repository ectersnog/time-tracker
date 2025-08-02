# frozen_string_literal: true

module Schemas
  module Errors
    def self.schema
      {
        error_response: {
          oneOf: [
            {
              type: :object,
              properties: {
                errors: { type: :string }
              }
            },
            {
              type: :object,
              properties: {
                errors: {
                  type: :array,
                  items: {
                    type: :string
                  }
                }
              }
            }
          ]
        }
      }
    end
  end
end
