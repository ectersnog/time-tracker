# frozen_string_literal: true

module LineItems
  class Create < ApplicationOperation
    def call(params:)
      line_item = step create_line_item(params:)
      step start_timer(line_item)
    end

    private

    def create_line_item(params:)
      list = List.find(params[:list])
      line_item = LineItem.new(task: params[:task], list:)
      if line_item.save
        Success(line_item)
      else
        Failure(line_item.errors.full_messages)
      end
    rescue ActiveRecord::RecordNotUnique
      Failure('LineItem already exists.')
    end

    def start_timer(line_item)
      time_entry = TimeEntry.new(line_item:, started_at: Time.current)
      return Success(line_item) if time_entry.save

      Failure(time_entry.errors.full_messages)
    end
  end
end
