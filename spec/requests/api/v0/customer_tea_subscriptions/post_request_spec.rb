require 'rails_helper'

RSpec.describe "Subscribe a customer to a tea subscription" do
  before(:each) do
    @assam_tea = Tea.create!(name: 'Assam Tea', description: 'A medium-bodied, brisk organic black tea with a distinctive malty flavor. A satisfying cup that is good with or without milk and sweetener.', brew_temp_f: 200, brew_time_min: 3, brew_time_max: 5)
    @sub_3 = Subscription.create!(title: 'Three Month Subscription', price: 16, plan_length: 3)
    @cust_1 = Customer.create!(first_name: 'John', last_name:'Smith', email: 'johnsmith423@email.com', street_address: '123 Main St', city: 'New York', state: 'NY', zip: '10001')
  end

  describe "Happy path" do
    it 'creates a new customer tea subscription' do
      params = { customer_id: @cust_1.id, tea_id: @assam_tea.id, subscription_id: @sub_3.id }
      @headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/subscriptions', headers: @headers, params: JSON.generate(params)

      expect(response).to be_successful
      expect(response.status).to eq(201)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:data)

      sub_data = data[:data]
      expect(sub_data).to be_a Hash

      expect(sub_data).to have_key(:id)
      expect(sub_data[:id]).to be_a String
      expect(sub_data).to have_key(:type)
      expect(sub_data[:type]).to eq('customer_tea_subscription')
      expect(sub_data).to have_key(:attributes)
      expect(sub_data[:attributes]).to be_a Hash

      subscr_attr = sub_data[:attributes]
      expect(subscr_attr).to have_key(:customer_id)
      expect(subscr_attr[:customer_id]).to be_a Integer
      expect(subscr_attr).to have_key(:tea_id)
      expect(subscr_attr[:tea_id]).to be_a Integer
      expect(subscr_attr).to have_key(:subscription_id)
      expect(subscr_attr[:subscription_id]).to be_a Integer
      expect(subscr_attr).to have_key(:status)
      expect(subscr_attr[:status]).to eq('active')
    end
  end

  describe "Sad path" do
    it 'returns an error if customer_id is invalid' do
      params = { customer_id: 20, tea_id: @assam_tea.id, subscription_id: @sub_3.id }
      @headers = { 'CONTENT_TYPE' => 'application/json' }

      post '/api/v0/subscriptions', headers: @headers, params: JSON.generate(params)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)

      error_data = JSON.parse(response.body, symbolize_names: true)
      expect(error_data).to be_a Hash
      expect(error_data).to have_key(:errors)
      expect(error_data[:errors]).to be_an Array
      error = error_data[:errors].first
      expect(error).to have_key(:status)
      expect(error[:status]).to eq('404')
      expect(error).to have_key(:title)
      expect(error[:title]).to eq('Record invalid')
      expect(error).to have_key(:detail)
      expect(error[:detail]).to eq('Validation failed: Customer must exist')
    end
  end
end
