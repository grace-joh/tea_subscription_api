class Api::V0::Customers::SubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_error_response

  def index
    customer = Customer.find(customer_params[:id])
    render json: CustomerSerializer.new(customer)
  end

  private

  def customer_params
    params.permit(:id)
  end

  def render_error_response(exception)
    render json: ErrorSerializer.serialize(exception, 404), status: 404
  end
end
