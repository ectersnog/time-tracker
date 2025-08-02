# frozen_string_literal: true

require 'swagger_helper'

RSpec.describe 'v1/lists' do
  path '/v1/lists' do
    get('lists index') do
      response '200', 'lists found' do
        schema '$ref': "#/components/schemas/list_response"

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

      response '200', 'create list' do
        schema '$ref': "#/components/schemas/list"
        let(:list) { { name: FFaker::Lorem.characters(10) } }

        run_test!
      end

      response '422', 'unprocessable entity' do
        schema '$ref': "#/components/schemas/error_response"

        before do
          create(:list, name: duplicate_name)
        end

        let(:list) { { name: duplicate_name } }

        run_test!
      end
    end
  end
  #
  # path '/v1/lists/{id}' do
  #   # You'll want to customize the parameter types...
  #   parameter name: 'id', in: :path, type: :string, description: 'id'
  #
  #   get('show list') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       run_test!
  #     end
  #   end
  #
  #   patch('update list') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       run_test!
  #     end
  #   end
  #
  #   put('update list') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       run_test!
  #     end
  #   end
  #
  #   delete('delete list') do
  #     response(200, 'successful') do
  #       let(:id) { '123' }
  #
  #       run_test!
  #     end
  #   end
end
