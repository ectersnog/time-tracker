# frozen_string_literal: true

module Lists
  class Create < ApplicationOperation
    # Creates a List
    #
    # @param params [hash]
    # @option params [String] :name The name of the List
    # @return [Dry::Monads::Result::Success<List>]
    # @see List
    def call(params:)
      step create_list(params[:name])
    end

    private

    def create_list(name)
      list = List.new(name:)
      if list.save
        Success(list)
      else
        Failure(list.errors.full_messages)
      end
    rescue ActiveRecord::RecordNotUnique
      Failure('List already exists.')
    end
  end
end
