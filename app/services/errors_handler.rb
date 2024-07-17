module ErrorsHandler
  class EmptyQueryParams < StandardError; end

  def self.included(klass)
    klass.class_eval do
      rescue_from ActiveRecord::RecordInvalid, with: :validation_error
      rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
      rescue_from Faraday::Error, with: :external_api_error
      rescue_from ErrorsHandler::EmptyQueryParams, with: :raise_if_blank
    end
  end

  def validation_error(error)
    render json: { status: :unprocessable_entity, message: error.record.errors.full_messages.to_sentence }, status: 422
  end

  def not_found_error
    render json: { status: :not_found, message: 'Record not found' }, status: 404
  end

  def external_api_error(error)
    render json: { status: :bad_request, message: error.message }, status: 400
  end

  def raise_if_blank
    render json: { status: :unprocessable_entity, message: 'Please fill the fields above' }, status: 422
  end
end
