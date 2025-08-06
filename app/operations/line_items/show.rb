# frozen_string_literal: true

module LineItems
  class Show < ApplicationOperation
    def call(params:)
      step find_list(params[:id])
    end

    private

    def find_list(id)
      line_item = LineItem.find(id)

      Success(line_item)
    end
  end
end
