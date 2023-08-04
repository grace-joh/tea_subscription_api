require 'rails_helper'

RSpec.describe "Subscribe a customer to a tea subscription" do
  before(:all) do
    # Teas
    @assam_tea = Tea.create!(name: 'Assam Tea', description: 'A medium-bodied, brisk organic black tea with a distinctive malty flavor. A satisfying cup that is good with or without milk and sweetener.', brew_temp_f: 200, brew_time_min: 3, brew_time_max: 5)
    @green_tea = Tea.create!(name: 'Green Tea', description: 'Our Organic Premium Green tea is expertly processed from beautifully handled leaves that are steam dried in the traditional Japanese style to preserve the flavor, fragrance, and color of the fresh leaf. The finished tea leaves are a vibrant green that brew into a bright golden-green liquor with a delicately herbaceous, slightly sweet and slightly nutty flavor.', brew_temp_f: 180, brew_time_min: 1, brew_time_max: 3)
    @oolong_tea = Tea.create!(name: 'Oolong Tea', description: 'Known in China as Lan Hua Oolong, this tea may be infused multiple times to reveal subtle differences. Very pale in the cup. Grown in Fujian Province.', brew_temp_f: 170, brew_time_min: 1, brew_time_max: 3)

    # Subscriptions
    @sub_3 = Subscription.create!(title: 'Three Month Subscription', price: 16, plan_length: 3)
    @sub_6 = Subscription.create!(title: 'Six Month Subscription', price: 15, plan_length: 6)
    @sub_12 = Subscription.create!(title: 'Twelve Month Subscription', price: 12, plan_length: 12)

    # Customers
    @cust_1 = Customer.create!(first_name: 'John', last_name: 'Smith', email: 'johnsmith423@email.com', street_address: '123 Main St', city: 'New York', state: 'NY', zip: '10001')
    @cust_2 = Customer.create!(first_name: 'Wei', last_name: 'Chen', email: 'wchen32@email.com', street_address: '456 Oak Rd', city: 'Los Angeles', state: 'CA', zip: '90001')
    @cust_3 = Customer.create!(first_name: 'Alejandro', last_name: 'Gomez', email: 'agomez99@email.com', street_address: '789 Elm St', city: 'Chicago', state: 'IL', zip: '60001')
    @cust_4 = Customer.create!(first_name: 'Jessica', last_name: 'Davis', email: 'jdavis044@email.com', street_address: '135 Pine Ave', city: 'Houston', state: 'TX', zip: '70001')
    @cust_5 = Customer.create!(first_name: 'Takashi', last_name: 'Sato', email: 'tsato88@email.com', street_address: '246 Cedar Ln', city: 'Phoenix', state: 'AZ', zip: '85001')
    @cust_6 = Customer.create!(first_name: 'Grace', last_name: 'Joh', email: 'test@email.com', street_address: '12456 Demo Rd', city: 'Dallas', state: 'TX', zip: '75057')

    # CustomerTeaSubscriptions
    # Customer 1 has 2 active subscriptions and 1 cancelled
    @cust_sub_11 = CustomerTeaSubscription.create!(customer: @cust_1, tea: @assam_tea, subscription: @sub_3, status: 0)
    @cust_sub_12 = CustomerTeaSubscription.create!(customer: @cust_1, tea: @green_tea, subscription: @sub_6, status: 0)
    @cust_sub_13 = CustomerTeaSubscription.create!(customer: @cust_1, tea: @oolong_tea, subscription: @sub_12, status: 1)
    # Customer 2 has 1 active subscription and 2 cancelled
    @cust_sub_21 = CustomerTeaSubscription.create!(customer: @cust_2, tea: @assam_tea, subscription: @sub_6, status: 0)
    @cust_sub_22 = CustomerTeaSubscription.create!(customer: @cust_2, tea: @oolong_tea, subscription: @sub_6, status: 1)
    @cust_sub_23 = CustomerTeaSubscription.create!(customer: @cust_2, tea: @oolong_tea, subscription: @sub_12, status: 1)
    # Customer 3 has 3 active subscriptions
    @cust_sub_31 = CustomerTeaSubscription.create!(customer: @cust_3, tea: @green_tea, subscription: @sub_3, status: 0)
    @cust_sub_32 = CustomerTeaSubscription.create!(customer: @cust_3, tea: @green_tea, subscription: @sub_12, status: 0)
    @cust_sub_33 = CustomerTeaSubscription.create!(customer: @cust_3, tea: @oolong_tea, subscription: @sub_12, status: 0)
    # Customer 4 has 2 cancelled subscriptions
    @cust_sub_41 = CustomerTeaSubscription.create!(customer: @cust_4, tea: @assam_tea, subscription: @sub_3, status: 1)
    @cust_sub_42 = CustomerTeaSubscription.create!(customer: @cust_4, tea: @oolong_tea, subscription: @sub_6, status: 1)
    # Customer 5 has 0 subscriptions

    @headers = { 'CONTENT_TYPE' => 'application/json' }
  end

  describe "Happy path" do
    it 'returns all of a customer\'s data' do
      get "/api/v0/customers/#{@cust_1.id}/subscriptions", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key(:data)

      customer_data = data[:data]
      # require "pry"; binding.pry
      expect(customer_data).to be_a Hash
      expect(customer_data).to have_key(:id)
      expect(customer_data[:id]).to be_a String
      expect(customer_data).to have_key(:type)
      expect(customer_data[:type]).to eq('customer')
      expect(customer_data).to have_key(:attributes)
      cust_attr = customer_data[:attributes]
      expect(cust_attr).to be_a Hash
      expect(cust_attr).to have_key(:first_name)
      expect(cust_attr[:first_name]).to be_a String
      expect(cust_attr).to have_key(:last_name)
      expect(cust_attr[:last_name]).to be_a String
      expect(cust_attr).to have_key(:email)
      expect(cust_attr[:email]).to be_a String
      expect(cust_attr).to have_key(:street_address)
      expect(cust_attr[:street_address]).to be_a String
      expect(cust_attr).to have_key(:city)
      expect(cust_attr[:city]).to be_a String
      expect(cust_attr).to have_key(:state)
      expect(cust_attr[:state]).to be_a String
      expect(cust_attr).to have_key(:zip)
      expect(cust_attr[:zip]).to be_a String
      expect(cust_attr).to have_key(:customer_tea_subscriptions)
      expect(cust_attr[:customer_tea_subscriptions]).to be_an Array
      expect(cust_attr[:customer_tea_subscriptions]).to all(be_a Hash)
    end

    it 'returns all of a customer\'s tea subscriptions - active and cancelled' do
      get "/api/v0/customers/#{@cust_1.id}/subscriptions", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      customer_subscriptions = data[:data][:attributes][:customer_tea_subscriptions]
      expect(customer_subscriptions.count).to eq(3)
      customer_subscriptions.each do |sub|
        expect(sub).to have_key(:id)
        expect(sub[:id]).to be_a Integer
        expect(sub).to have_key(:customer_id)
        expect(sub[:customer_id]).to be_a Integer
        expect(sub).to have_key(:tea_id)
        expect(sub[:tea_id]).to be_a Integer
        expect(sub).to have_key(:subscription_id)
        expect(sub[:subscription_id]).to be_a Integer
        expect(sub).to have_key(:status)
      end

      expect(customer_subscriptions[0][:status]).to eq('active')
      expect(customer_subscriptions[1][:status]).to eq('active')
      expect(customer_subscriptions[2][:status]).to eq('cancelled')
    end

    it 'returns all of another customer\'s tea subscriptions - active and cancelled' do
      get "/api/v0/customers/#{@cust_2.id}/subscriptions", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      customer_subscriptions = data[:data][:attributes][:customer_tea_subscriptions]
      expect(customer_subscriptions.count).to eq(3)
      expect(customer_subscriptions[0][:status]).to eq('active')
      expect(customer_subscriptions[1][:status]).to eq('cancelled')
      expect(customer_subscriptions[2][:status]).to eq('cancelled')
    end

    it 'returns all of a customer\'s tea subscriptions - active only' do
      get "/api/v0/customers/#{@cust_3.id}/subscriptions", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      customer_subscriptions = data[:data][:attributes][:customer_tea_subscriptions]
      expect(customer_subscriptions.count).to eq(3)
      expect(customer_subscriptions[0][:status]).to eq('active')
      expect(customer_subscriptions[1][:status]).to eq('active')
      expect(customer_subscriptions[2][:status]).to eq('active')
    end

    it 'returns all of a customer\'s tea subscriptions - cancelled only' do
      get "/api/v0/customers/#{@cust_4.id}/subscriptions", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      customer_subscriptions = data[:data][:attributes][:customer_tea_subscriptions]
      expect(customer_subscriptions.count).to eq(2)
      expect(customer_subscriptions[0][:status]).to eq('cancelled')
      expect(customer_subscriptions[1][:status]).to eq('cancelled')
    end

    it 'returns an empty array if a customer has no tea subscriptions' do
      get "/api/v0/customers/#{@cust_5.id}/subscriptions", headers: @headers

      expect(response).to be_successful
      expect(response.status).to eq(200)

      data = JSON.parse(response.body, symbolize_names: true)

      customer_subscriptions = data[:data][:attributes][:customer_tea_subscriptions]
      expect(customer_subscriptions.count).to eq(0)
    end
  end

  describe "Sad path" do
    it 'returns an error if customer_id is invalid' do
      get "/api/v0/customers/0/subscriptions", headers: @headers

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
      expect(error[:detail]).to eq("Couldn't find Customer with 'id'=0")
    end
  end
end
