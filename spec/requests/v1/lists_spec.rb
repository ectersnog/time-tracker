# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/lists' do
  path '/v1/lists' do
    get('lists index') do
      response 200, 'lists found' do
        schema '$ref': "#/components/schemas/lists_response"

        before do
          create_list(:list, 3)
        end

        run_test!
      end
    end

    post('create list') do
      consumes 'application/json'
      produces 'application/json'
      parameter name: :list, in: :body, required: true, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        }
      }

      let!(:duplicate_name) { FFaker::Lorem.characters(10) }

      response 200, 'create list' do
        schema '$ref': "#/components/schemas/list_response"
        let(:list) { { name: FFaker::Lorem.characters(10) } }

        run_test!
      end

      response 422, 'unprocessable entity' do
        schema '$ref': "#/components/schemas/error_response"

        before do
          create(:list, name: duplicate_name)
        end

        let(:list) { { name: duplicate_name } }

        run_test!
      end
    end
  end

  path '/v1/lists/{id}' do
    let!(:list) { create(:list) }
    let(:id) { list.id }

    get('show list') do
      parameter name: 'id', in: :path, type: :string
      response 200, 'successful' do
        schema '$ref': "#/components/schemas/list_response"

        run_test!
      end

      response 404, 'not found' do
        schema '$ref': "#/components/schemas/error_response"
        let(:id) { 'invalid' }

        run_test!
      end
    end

    put('update list') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'id', in: :path, type: :string
      parameter name: :list, in: :body, required: true, schema: {
        '$ref': "#/components/schemas/list_update"
      }
      response 200, 'successful' do
        let(:existing_list) { create(:list) }
        let(:id) { existing_list.id }

        let(:list) { { name: 'New List Name' } }

        run_test! do |response|
          expect(response).to have_http_status(:ok)
          expect(existing_list.reload.name).to eq('New List Name')
        end
      end

      response 422, 'unprocessable entity' do
        let(:existing_list) { create(:list) }
        let(:id) { existing_list.id }

        let(:list) { { name: 'abc' } }

        run_test!
      end

      response 404, 'not found' do
        schema '$ref': "#/components/schemas/error_response"
        let(:id) { 'invalid' }

        run_test!
      end
    end

    delete('delete list') do
      consumes 'application/json'
      produces 'application/json'

      parameter name: 'id', in: :path, type: :string

      response 200, 'successful' do
        schema '$ref': "#/components/schemas/deleted_response"
        let(:list) { create(:list) }
        let(:id) { list.id }

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
