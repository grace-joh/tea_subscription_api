class Api::V0::CustomerTeaSubscriptionsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid

  def create
    @sub = CustomerTeaSubscription.create!(customer_tea_subscription_params)
    render json: CustomerTeaSubscriptionSerializer.new(@sub), status: 201
  end

  private

  def customer_tea_subscription_params
    params.permit(:customer_id, :tea_id, :subscription_id)
  end

  def render_record_invalid(exception)
    render json: ErrorSerializer.serialize(exception, 404), status: 404
  end
end
