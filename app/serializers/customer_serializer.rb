class CustomerSerializer
  include JSONAPI::Serializer

  attributes :id,
             :first_name,
             :last_name,
             :email,
             :street_address,
             :city,
             :state,
             :zip,
             :customer_tea_subscriptions
end
