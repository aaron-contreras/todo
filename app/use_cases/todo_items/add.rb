# frozen_string_literal: true

module TodoItems
  class Add
    ResponseModel = Struct.new(:success?, :errors)

    def initialize(request_model:)
      @request_model = request_model
      @errors = []
    end

    def perform!
      validate_request_model

      return error_response unless errors.empty?

      TodoItem.create(todo_attributes)
      
      success_response
    end

    private

    attr_reader :request_model, :errors

    def validate_request_model
      errors << ":title is missing" if request_model[:title].nil?
      errors << ":title can't be blank" if request_model[:title].blank?
    end

    def todo_attributes
      {
        title: request_model[:title]
      }
    end

    def success_response
      ResponseModel.new(true, [])
    end

    def error_response
      ResponseModel.new(false, errors)
    end
  end
end