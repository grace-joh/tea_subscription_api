class Subscription < ApplicationRecord
  has_many :customer_tea_subscriptions

  enum :status, { active: 0, cancelled: 1 }
end
