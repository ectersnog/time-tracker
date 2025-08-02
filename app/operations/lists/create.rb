# frozen_string_literal: true

module Lists
  class Create < ApplicationOperation
    def call(params:)
      step create_list(params[:name])
    end

    private

    def create_list(name)
      list = List.new(name:)
      Success(list) if list.save

    rescue ActiveRecord::RecordNotUnique
      Failure('List already exists.')
    end
  end
end
