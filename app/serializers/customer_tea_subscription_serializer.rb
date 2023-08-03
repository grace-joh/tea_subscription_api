class CustomerTeaSubscriptionSerializer
  include JSONAPI::Serializer

  attributes :id,
             :customer_id,
             :tea_id,
             :subscription_id,
             :status
end
