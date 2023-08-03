require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should have_many(:customer_tea_subscriptions) }
  end
end
