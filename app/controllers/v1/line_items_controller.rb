# frozen_string_literal: true

module V1
  class LineItemsController < ApplicationController
    def index
      result = LineItems::Index.call
      if result.success?
        render locals: { line_items: result.success }, status: :ok
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end

    def show
      result = LineItems::Show.call(params:)

      if result.success?
        render locals: { line_item: result.success }
      else
        render json: { errors: [result.failure] }, status: :not_found
      end
    end

    def create
      result = LineItems::Create.call(params:)

      if result.success?
        render locals: { line_item: result.success }
      else
        render json: { errors: [result.failure] }, status: :unprocessable_entity
      end
    end

    def update
      result = LineItems::Update.call(params:)

      if result.success?
        render locals: { line_item: result.success }
      else
        render json: { errors: [result.failure] }, status: :unprocessable_entity
      end
    end

    def destroy
      result = LineItems::Destroy.call(params:)

      if result.success?
        render locals: { line_item: result.success }
      else
        render json: { errors: [result.failure] }, status: :unprocessable_entity
      end
    end
  end
end
