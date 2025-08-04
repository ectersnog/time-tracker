# frozen_string_literal: true

module LineItems
  class Destroy < ApplicationOperation
    def call(params:)
      step destroy(params[:id])
    end

    private

    def destroy(id)
      line_item = LineItem.find(id)
      Success(line_item.destroy)
    end
  end
end
