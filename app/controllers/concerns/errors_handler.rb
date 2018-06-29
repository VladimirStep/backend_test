module ErrorsHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :active_record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from ActionController::ParameterMissing, with: :unprocessable_params
  end

  def active_record_not_found(exception)
    render json: { error: "#{exception.model.titleize} not found" }, status: :not_found
  end

  def unprocessable_entity(exception)
    render json: { error: exception.record.errors.as_json(full_messages: true) }, status: :unprocessable_entity
  end

  def unprocessable_params(exception)
    render json: { error: "#{exception.message}" }, status: :unprocessable_entity
  end
end