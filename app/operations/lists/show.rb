# frozen_string_literal: true

module Lists
  class Show < ApplicationOperation
    def call(params:)
      step find_list(params[:id])
    end

    private

    def find_list(id)
      list = List.find(id)

      Success(list)
    end
  end
end
