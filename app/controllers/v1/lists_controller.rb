# frozen_string_literal: true

module V1
  class ListsController < ApplicationController
    def index
      result = Lists::Index.call
      if result.success?
        render locals: { lists: result.success }
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end

    def show
      result = Lists::Show.call(params:)

      if result.success?
        render locals: { list: result.success }
      else
        render json: { errors: [result.failure] }, status: :not_found
      end
    end

    def create
      result = Lists::Create.call(params:)

      if result.success?
        render locals: { list: result.success }
      else
        render json: { errors: [result.failure] }, status: :unprocessable_entity
      end
    end

    def update
      result = Lists::Update.call(params:)

      if result.success?
        render locals: { list: result.success }
      else
        render json: { errors: [result.failure] }, status: :unprocessable_entity
      end
    end

    def destroy
      result = Lists::Destroy.call(params:)

      if result.success?
        render locals: { list: result.success }
      else
        render json: { errors: [result.failure] }, status: :unprocessable_entity
      end
    end
  end
end
