# frozen_string_literal: true

module Lists
  class Index < ApplicationOperation
    def call
      step index
    end

    private

    def index
      list = List.all
      Success(list)
    end
  end
end
