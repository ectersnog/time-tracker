# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/reports' do
  path '/v1/reports' do
    post('generate a report') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: :reports_params, in: :body, required: true, schema: {
        '$ref' => '#/definitions/reports_params'
      }
      response 200, 'successful' do
        schema '$ref' => '#/components/schemas/report_response'

        let(:reports_params) do
          {
            start: 'August 3rd, 2025',
            end: 'August 5th, 2025'
          }
        end

        run_test!
      end
    end
  end
end
