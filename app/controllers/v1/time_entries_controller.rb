# frozen_string_literal: true

module V1
  class TimeEntriesController < ApplicationController
    def index
      result = TimeEntries::Index.call
      if result.success?
        render locals: { time_entries: result.success }, status: :ok
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end

    def show
      result = TimeEntries::Show.call(params:)

      if result.success?
        render locals: { time_entry: result.success }
      else
        render json: { errors: [result.failure] }, status: :not_found
      end
    end

    def create
      result = TimeEntries::Create.call(params:)

      if result.success?
        render locals: { time_entry: result.success }
      else
        render json: { errors: [result.failure] }, status: :unprocessable_entity
      end
    end

    def update
      result = TimeEntries::Update.call(params:)

      if result.success?
        render locals: { time_entry: result.success }
      else
        render json: { errors: [result.failure] }, status: :unprocessable_entity
      end
    end

    def destroy
      result = TimeEntries::Destroy.call(params:)

      if result.success?
        render locals: { time_entry: result.success }
      else
        render json: { errors: [result.failure] }, status: :unprocessable_entity
      end
    end
  end
end
