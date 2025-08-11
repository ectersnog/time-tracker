# frozen_string_literal: true

module V1
  class ReportsController < ApplicationController
    def index
      result = Reports::Index.call(params:)

      if result.success?
        render locals: { report: result.success }
      else
        render json: { errors: [result.errors] }, status: :unprocessable_entity
      end
    end
  end
end
