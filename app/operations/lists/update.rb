# frozen_string_literal: true

module Lists
  class Update < ApplicationOperation
    def call(params:)
      step update_list(params:)
    end

    private

    def update_list(params:)
      list = List.find(params[:id])

      if list.update(name: params[:name])
        Success(list)
      else
        Failure(list.errors.full_messages)
      end
    end
  end
end
