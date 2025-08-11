# frozen_string_literal: true

module Lists
  class Index < ApplicationOperation
    # Gets a list of all Lists
    #
    # @return [Dry::Monads::Result::Success<ActiveRecord::Relation<List>>]
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
