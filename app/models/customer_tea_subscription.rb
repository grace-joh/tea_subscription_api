class CustomerTeaSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea
  belongs_to :subscription
end
