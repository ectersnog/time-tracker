# frozen_string_literal: true

module Lists
  class Create < ApplicationOperation
    def call(params:)
      step create_list(params[:name])
    end

    private

    def create_list(name)
      list = List.new(name:)
      return Success(list) if list.save

      Failure(list.errors.full_messages)
    end
  end
end
