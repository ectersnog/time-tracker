# frozen_string_literal: true

module LineItems
  class Update < ApplicationOperation
    def call(params:)
      step update_list(params:)
    end

    private

    def update_list(params:)
      line_item = LineItem.find(params[:id])

      if line_item.update(task: params[:task])
        Success(line_item)
      else
        Failure(line_item.errors.full_messages)
      end
    end
  end
end
