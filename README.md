<!-- insert image ![]() -->
<h1 align="center">Tea Subscription API</h1>

## About

Tea Subscription is a REST API that exposes three endpoints to manage a tea subscription service:
* subscribe a customer to a tea subscription
* cancel a customer's tea subscription
* see all of a customer's subscriptions (active and cancelled)

</br>
This API is a project that mimics a take home assessment from the [Turing School of Software and Design](turing.edu), preparing students for a technical interview process. 

This assessment checks for:
* A strong understanding of Rails
* Ability to create restful routes
* Demonstration of well-organized code, following OOP
* Test Driven Development
* Clear documentation

</br>

See the [Prompt](https://mod4.turing.edu/projects/take_home/take_home_be) for more details.

## Table of Contents

1. [Built with](#built-with)
1. [Getting Started](#getting-started)
    * [Installation](#installation)
    * [Testing](#testing)
1. [Endpoints](#endpoints)
1. [Database Schema Design](#database-schema-design)
1. [Planning Process](#planning-process)
    * [Understanding the Product](#understanding-the-product)
    * [Database Relationships](#database-relationships)
    * [GitHub Projects Set Up](#github-projects-set-up)
    * [JSON Contract](#json-contract)
    * [Pull Request Template](#pull-request-template)
1. [Refactors and Future Implementations](#refactors-and-future-implementations)
1. [About the Developer](#about-the-developer)

## Built with

* Ruby on Rails v 7.0.6
* Ruby v 3.1.1
* PostgreSQL
* Visual Studio Code

## Getting Started

### Installation

In your terminal:
1. Fork and clone the repository locally: 
    > `git clone git@github.com:grace-joh/tea_subscription_api.git`
1. Navigate into the directory:
    > `cd tea_subscription_api`
1. Install gem packages: 
    > `bundle install`
1. Setup the database:
    > `rails db:{create,migrate}`
1. I created my own dummy data for the purpose of this assessment. To seed the database with this data, run:
    > `rails db:seed`

### Testing

To run all tests from your command line:
* Run `bundle exec rspec`

All 18 tests should be passing. Happy and sad path cases were accounted for and tested for each [endpoint](##endpoints).

To test the endpoints:
* In your terminal, run `rails s` to start a local server.
* Use an API platform like [Postman](https://app.getpostman.com/run-collection/26085409-1cb627ef-d500-4f6f-b849-9b655205c7ed?action=collection%2Ffork&collection-url=entityId%3D26085409-1cb627ef-d500-4f6f-b849-9b655205c7ed%26entityType%3Dcollection%26workspaceId%3Df402ed1d-531c-4451-ad21-b6367689bff9) or a REST API client extension like [Thunder Client](https://www.thunderclient.io/) using your local server address and the endpoints below.

## Endpoints
#### POST `/api/v0/subscriptions`
  <details><summary>Request</summary>

  ```json
    {
      "customer_id": "1",
      "tea_id": "1",
      "subscription_id": "1"
    }
  ```
  </details>
  <details><summary>Response</summary>

  Status 200 OK
  ```json
    {
      "data": {
        "type": "customer_tea_subscription",
        "id": "1",
        "attributes": {
          "customer_id": 1,
          "tea_id": 1,
          "subscription_id": 1,
          "status": "active"
        }
      }
    }
  ```
  </details>

  #### PATCH `/api/v0/subscriptions`
  <details><summary>Request</summary>

  ```json
    {
      "customer_id": "1",
      "tea_id": "1",
      "subscription_id": "1"
    }
  ```
  </details>
  <details><summary>Response</summary>
  
  Status 200 OK

  ```json
    {
      "data": {
        "type": "customer_tea_subscription",
        "id": "1",
        "attributes": {
          "customer_id": 1,
          "tea_id": 1,
          "subscription_id": 1,
          "status": "cancelled"
        }
      }
    }
  ```
  </details>
  
  #### GET `/api/v0/customer/:id/subscriptions`
  <details><summary>Response</summary>
  
  Status 200 OK

  ```json
    {
      "data": {
        "type": "customer",
        "id": 1,
        "attributes": {
          "first_name": "1",
          "last_name": "1",
          "email": "1",
          "street_address": "active",
          "city": "1",
          "state": "1",
          "zip": "1"
          "customer_tea_subscriptions": [
            {
                "id":  1,
                "customer_id": 1,
                "tea_id": 1,
                "subscription_id": 1,
                "status": "active" 
            },
            {
                "id":  2,
                "customer_id": 1,
                "tea_id": 2,
                "subscription_id": 2,
                "status": "cancelled" 
            },
            ... 
          ]
        }
      }
    }
  ```
  </details>

  #### Error Handling Example
  <details><summary>Response</summary>
  Status 404 Not Found

  ```json
    {
      "errors": [
        {
          "status": "404",
          "title":  "Customer not found",
          "detail": "The customer with id -1 does not exist."
        }
      ]
    }
  ```
  </details>


## Database Schema Design
<!-- insert image ![]() -->
Many considerations were taken into account when designing the database schema. See [Database Relationships](#database-relationships) for more details.

## Planning Process

### Understanding the Product

<details>
  <summary style="font-weight: 700;"> Business Decisions about the Subscription Service</summary>
  Before building my database and API endpoints, I took several factors of a tea subscription service into consideration. I had many initial questions:

  - What kind of subscriptions do the business provide?
    - Is it a single tea, a set of multiple teas, or different teas every delivery? And the amount of tea? 
    - Is there a variety of options for subscription by frequency (how often tea is delivered) or by plan length (every month for __ number of months)?
    - Is price determined by tea or by subscription frequency?
  - Are tea subscriptions set by the business or will users be able to customize their subscription?
  
  I considered the above from a business perspective, but ultimately decided on a streamlined product from a developer perspective to create a MVP (minimum viable product).
  - Each subscription "box" comes with 3 oz of a single tea or an assorted tea set (decided by the business) of three teas, 1 oz each.
  - Monthly subscriptions will be available by plan length.
    - Plan A: 3 Months at $16/month
    - Plan B: 6 Months at $15/month
    - Plan C: 12 Months at $12/month
  - Price
    - For the MVP, the price of the subscription will be determined by plan as listed above
    - For beyond the MVP, I would like to implement the following:
      - The price of a single tea subscription will be determined by tea per ounce.
      - The price of a tea assortment will be set by the business.
    
Making these "business" decisions first helped me to start with a focused product to build my database and endpoints.

### Database Relationships
</details>
</br>
<details>
  <summary style="font-weight: 700;">Database Relationships</summary>
  Next, I considered the relationships between Tea, Customer, and Subscription. 
  </br>
  First, I drew a plan for a many-to-many relationship between teas and subscriptions so that a subscription could consist of many teas. In addition, subscriptions and customers would also be a many-to-many relationship so that a customer could have many subscriptions, and thus with many teas to be subscribed to under a single subscription.
  <!-- insert image ![]() -->
  However, the above option felt overengineered for user customization in this case where the subscription service by tea and plan length are predetermined by the business decisions above. So I considered a simple design with the Tea and Customer tables having a many-to-many relationship with Subscription as the joins table between the two. 
  <!-- insert image ![]() -->
  When considering my endpoints and HTTP requests for this design, I imagined that it would require the subscription attributes, like frequency and price, to be sent in the request body. This would be a lot of information to send in the request body, and I wanted to keep the request body as minimal as possible. So then, I considered a third option to create a table for the predetermined subscription plans. Then teas and subscriptions would have a many-to-many relationship, and then the join table could have a many-to-many relationship with customers.
  <!-- insert image ![]() -->
  After second look in this database design, the two join tables felt repetitive. I reduced the design to have a single join table between the three tables: Tea, Customer, and Subscription. 
  This would allow for a customer to have many subscriptions, and a subscription to have many teas. Another advantange is that the subscription attributes, like frequency and price, would be stored in the subscription table. This would allow for a minimal request body for the POST and PATCH requests. A disadvantage, however, was that in the JSON response for all the requests, only the tea id and subscription ids would be returned. I would like to add tea and subscription attributes in a future refactor.
  <!-- insert image ![]() -->
</details>
</br>
<details>
  <summary style="font-weight: 700;">Determining RESTful Endpoints</summary>
  The three required endpoints are: 
  - Subscribe a customer to a tea subscription
  - Cancel a customer’s tea subscription (cancelled status)
  - See all of a customer’s subsciptions (active and cancelled)

  My initial thoughts and questions:
  - The required endpoints can be routed to a single Subscriptions Controller with the verbs: POST, PATCH, and GET. 
  - Subscriptions should be included in the URI path as it is what is being created, updated, and read.
  - Could subscriptions be nested under user or tea? Should user id and/or be sent via the URI path -> through the request body?
  
  Brainstorming URI endpoint options:
  1. Subscription -> `/api/v0/subscriptions`
    - POST and PATCH requests would send customer id and tea id in the request body
    - GET request for all a customer's subscriptions would require customer id as a query parameter -> Nope!
  1. Subscription via Customer -> `/api/v0/customer/:id/subscriptions`
    - POST and PATCH requests would send tea id in the request body
    - GET request for all a customer's subscriptions indicate customer id in the URI path
  1. Subscription via Tea -> `/api/v0/tea/:id/subscriptions`
    - POST and PATCH requests would send customer id in the request body
    - GET request for all a customer's subscriptions would require customer id as a query parameter -> Nope!

  I opted for a combination of Option 2 and 3, considering all three API endpoints (particularly the GET request) require a customer's id.
</details>

### GitHub Projects Set Up
I utilized GitHub Projects to keep track of my progress and to keep myself organized. I created a Project Board with three columns: To Do, In Progress, and Done. I created issues and branches for each task and utilized them to guide my GitHub workflow.
<!-- insert image ![]() -->

### JSON Contract
In each endpoint task in my GiHub Project Board, I created a JSON contract to help me visualize the request and response bodies, as well as happy and sad paths. I also used the JSON contract to help me organize the attributes for each table in my database schema design.
<!-- insert image ![]() -->

### Pull Request Template
I created a pull request template to help organize my work for each branch. I included a checklist to ensure all tests were passing (with 100% coverage!). I also included a section to record future notes to myself regarding questions, concerns, future refactors, and self-encouragement. This helped me to stay organized and to keep track of my progress.
<!-- insert image ![]() -->

## Refactors and Future Implementations
Coming soon...

## About the Developer

* Grace Joh - [![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/grace-joh)


