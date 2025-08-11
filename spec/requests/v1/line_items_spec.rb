# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/line_items' do
  path '/v1/line_items' do
    get('line_items index') do
      response 200, 'line_items found' do
        schema '$ref': "#/components/schemas/line_items_response"

        before do
          create_list(:line_item, 3)
        end

        run_test!
      end
    end

    post('create line_item') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :line_item, in: :body, required: true, schema: {
        type: :object,
        properties: {
          task: { type: :string }
        }
      }

      let!(:list) { create(:list) }
      let!(:duplicate_name) { FFaker::Lorem.characters(10) }

      response 200, 'create line_item' do
        schema '$ref': "#/components/schemas/line_item_response"
        let(:line_item) { { task: FFaker::Lorem.characters(10), list: list.id } }

        run_test!
      end

      response 422, 'unprocessable entity' do
        schema '$ref': "#/components/schemas/error_response"

        before do
          create(:line_item, task: duplicate_name, list:)
        end

        let(:line_item) { { task: duplicate_name, list: list.id } }

        run_test!
      end
    end
  end

  path '/v1/line_items/{id}' do
    let!(:line_item) { create(:line_item) }
    let(:id) { line_item.id }

    get('show line_item') do
      parameter name: 'id', in: :path, type: :string
      response 200, 'successful' do
        schema '$ref': "#/components/schemas/line_item_response"

        run_test!
      end

      response 404, 'not found' do
        schema '$ref': "#/components/schemas/error_response"
        let(:id) { 'invalid' }

        run_test!
      end
    end

    put('update line_item') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'id', in: :path, type: :string
      parameter name: :line_item, in: :body, required: true, schema: {
        '$ref': "#/components/schemas/line_item_update"
      }
      response 200, 'successful' do
        let(:existing_line_item) { create(:line_item) }
        let(:id) { existing_line_item.id }

        let(:line_item) { { task: 'New List Name' } }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(existing_line_item.reload.task).to eq('New List Name')
        end
      end

      response 422, 'unprocessable entity' do
        let(:existing_line_item) { create(:line_item) }
        let(:id) { existing_line_item.id }

        let(:line_item) { { task: 'abc' } }

        run_test!
      end

      response 404, 'not found' do
        schema '$ref': "#/components/schemas/error_response"
        let(:id) { 'invalid' }

        run_test!
      end
    end

    delete('delete line_item') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'id', in: :path, type: :string

      response 200, 'successful' do
        schema '$ref': "#/components/schemas/deleted_response"
        let(:line_item) { create(:line_item) }
        let(:id) { line_item.id }

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
