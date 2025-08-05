# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/time_entries' do
  path '/v1/time_entries' do
    get('time_entries index') do
      response 200, 'time_entries found' do
        schema '$ref': "#/components/schemas/time_entries_response"

        before do
          create_list(:time_entry, 3)
        end

        run_test!
      end
    end

    post('create time_entry') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :time_entry, in: :body, required: true, schema: {
        type: :object,
        properties: {
          task: { type: :string }
        }
      }

      let!(:line_item) { create(:line_item) }

      response 200, 'create time_entry' do
        schema '$ref': "#/components/schemas/time_entry_response"
        let(:time_entry) { { started_at: Time.current, line_item: line_item.id } }

        run_test!
      end

      response 422, 'unprocessable entity' do
        schema '$ref': "#/components/schemas/error_response"

        let(:time_entry) { { started_at: 1.hour.from_now, stopped_at: 1.hour.ago, line_item: line_item.id } }

        run_test!
      end
    end
  end

  path '/v1/time_entries/{id}' do
    let!(:time_entry) { create(:time_entry) }
    let(:id) { time_entry.id }

    get('show time_entry') do
      parameter name: 'id', in: :path, type: :string
      response 200, 'successful' do
        schema '$ref': "#/components/schemas/time_entry_response"

        run_test!
      end

      response 404, 'not found' do
        schema '$ref': "#/components/schemas/error_response"
        let(:id) { 'invalid' }

        run_test!
      end
    end

    put('update time_entry') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'id', in: :path, type: :string
      parameter name: :time_entry, in: :body, required: true, schema: {
        '$ref': "#/components/schemas/time_entry_update"
      }
      response 200, 'successful' do
        let(:existing_time_entry) { create(:time_entry) }
        let(:id) { existing_time_entry.id }
        time = Time.zone.local(1992, 12, 24, 11, 59, 0)
        let(:time_entry) { { started_at: time } }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(existing_time_entry.reload.started_at).to eq(time)
        end
      end

      response 422, 'unprocessable entity' do
        let(:existing_time_entry) { create(:time_entry) }
        let(:id) { existing_time_entry.id }

        let(:time_entry) { { started_at: Time.current, stopped_at: 1.hour.ago } }

        run_test!
      end

      response 404, 'not found' do
        schema '$ref': "#/components/schemas/error_response"
        let(:id) { 'invalid' }

        run_test!
      end
    end

    delete('delete time_entry') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'id', in: :path, type: :string

      response 200, 'successful' do
        schema '$ref': "#/components/schemas/deleted_response"
        let(:time_entry) { create(:time_entry) }
        let(:id) { time_entry.id }

        run_test!
      end

      response 404, 'not found' do
        schema '$ref': "#/components/schemas/error_response"
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end
