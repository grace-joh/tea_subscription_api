# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Teas
# Source: https://www.stashtea.com/
assam_tea = Tea.create!(name: 'Assam Tea', description: 'A medium-bodied, brisk organic black tea with a distinctive malty flavor. A satisfying cup that is good with or without milk and sweetener.', brew_temp_f: 200, brew_time_min: 3, brew_time_max: 5)
green_tea = Tea.create!(name: 'Green Tea', description: 'Our Organic Premium Green tea is expertly processed from beautifully handled leaves that are steam dried in the traditional Japanese style to preserve the flavor, fragrance, and color of the fresh leaf. The finished tea leaves are a vibrant green that brew into a bright golden-green liquor with a delicately herbaceous, slightly sweet and slightly nutty flavor.', brew_temp_f: 180, brew_time_min: 1, brew_time_max: 3)
oolong_tea = Tea.create!(name: 'Oolong Tea', description: 'Known in China as Lan Hua Oolong, this tea may be infused multiple times to reveal subtle differences. Very pale in the cup. Grown in Fujian Province.', brew_temp_f: 170, brew_time_min: 1, brew_time_max: 3)

# Subscriptions
sub_3 = Subscription.create!(title: 'Three Month Subscription', price: 16, plan_length: 3)
sub_6 = Subscription.create!(title: 'Six Month Subscription', price: 15, plan_length: 6)
sub_12 = Subscription.create!(title: 'Twelve Month Subscription', price: 12, plan_length: 12)

# Customers
cust_1 = Customer.create!(first_name: 'John', last_name:'Smith', email: 'johnsmith423@email.com', street_address: '123 Main St', city: 'New York', state: 'NY', zip: '10001')
cust_2 = Customer.create!(first_name: 'Wei', last_name:'Chen', email: 'wchen32@email.com', street_address: '456 Oak Rd', city: 'Los Angeles', state: 'CA', zip: '90001')
cust_3 = Customer.create!(first_name: 'Alejandro', last_name:'Gomez', email: 'agomez99@email.com', street_address: '789 Elm St', city: 'Chicago', state: 'IL', zip: '60001')
cust_4 = Customer.create!(first_name: 'Jessica', last_name:'Davis', email: 'jdavis044@email.com', street_address: '135 Pine Ave', city: 'Houston', state: 'TX', zip: '70001')
cust_5 = Customer.create!(first_name: 'Takashi', last_name:'Sato', email: 'tsato88@email.com', street_address: '246 Cedar Ln', city: 'Phoenix', state: 'AZ', zip: '85001')

# CustomerTeaSubscriptions
# Customer 1 has 2 active subscriptions and 1 cancelled
cust_sub_11 = CustomerTeaSubscription.create!(customer: cust_1, tea: assam_tea, subscription: sub_3, status: 0)
cust_sub_12 = CustomerTeaSubscription.create!(customer: cust_1, tea: green_tea, subscription: sub_6, status: 0)
cust_sub_13 = CustomerTeaSubscription.create!(customer: cust_1, tea: oolong_tea, subscription: sub_12, status: 1)
# Customer 2 has 1 active subscription and 2 cancelled
cust_sub_21 = CustomerTeaSubscription.create!(customer: cust_2, tea: assam_tea, subscription: sub_6, status: 0)
cust_sub_22 = CustomerTeaSubscription.create!(customer: cust_2, tea: oolong_tea, subscription: sub_6, status: 1)
cust_sub_23 = CustomerTeaSubscription.create!(customer: cust_2, tea: oolong_tea, subscription: sub_12, status: 1)
# Customer 3 has 3 active subscriptions
cust_sub_31 = CustomerTeaSubscription.create!(customer: cust_3, tea: green_tea, subscription: sub_3, status: 0)
cust_sub_32 = CustomerTeaSubscription.create!(customer: cust_3, tea: green_tea, subscription: sub_12, status: 0)
cust_sub_33 = CustomerTeaSubscription.create!(customer: cust_3, tea: oolong_tea, subscription: sub_12, status: 0)
# Customer 4 has 2 cancelled subscriptions
cust_sub_41 = CustomerTeaSubscription.create!(customer: cust_4, tea: assam_tea, subscription: sub_3, status: 1)
cust_sub_42 = CustomerTeaSubscription.create!(customer: cust_4, tea: oolong_tea, subscription: sub_6, status: 1)
# Customer 5 has 0 subscriptions
