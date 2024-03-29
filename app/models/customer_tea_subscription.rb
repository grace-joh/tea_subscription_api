class CustomerTeaSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
  belongs_to :subscription

  enum :status, { active: 0, cancelled: 1 }
end
