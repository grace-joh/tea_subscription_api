class Api::V0::CustomerTeaSubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_error_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_error_response

  def create
    @sub = CustomerTeaSubscription.create!(customer_tea_subscription_params)
    render json: CustomerTeaSubscriptionSerializer.new(@sub), status: 201
  end

  def update
    @sub = CustomerTeaSubscription.find_by!(customer_tea_subscription_params)
    @sub.cancelled!
    render json: CustomerTeaSubscriptionSerializer.new(@sub), status: 200
  end

  private

  def customer_tea_subscription_params
    params.permit(:customer_id, :tea_id, :subscription_id)
  end

  def render_error_response(exception)
    render json: ErrorSerializer.serialize(exception, 404), status: 404
  end
end
