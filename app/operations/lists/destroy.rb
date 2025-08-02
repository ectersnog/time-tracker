# frozen_string_literal: true

module Lists
  class Destroy < ApplicationOperation
    def call(params:)
      step destroy(params[:id])
    end

    private

    def destroy(id)
      list = List.find(id)
      Success(list.destroy)
    end
  end
end
