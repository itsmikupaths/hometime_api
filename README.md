# Hometime API

This is a simple Rails API that allows you to create reservations for guests, authenticate requests with API keys, and manage the API keys for trusted applications.

Ruby 3.3.0
Rails 7.1.5.1

## Table of Contents
1. [Setup](#setup)
2. [API Usage](#api-usage)
   - [Generate API Key](#generate-api-key)
   - [Reservation Endpoint](#reservation-endpoint)
3. [Testing](#testing)

---

## Setup

### 1. Clone the repository

Clone this repository to your local machine using:

```bash
git clone https://github.com/itsmikupaths/hometime_api.git
```

### 2. Install Dependencies
Open terminal and change directory to the app.

Run the following command to install the required gems:

```bash
bundle install
```

### 3. Set up the database
Create and migrate the database with the following commands:

```bash
rails db:create
rails db:migrate
```

### 4. Start the Rails server
To start the Rails server, run:

```bash
rails server
```
Verify if API is up and running http://localhost:3000/api/v1/health_check

## API Usage
This API requires authentication using API keys. All requests must include a valid API key.

A simple end-point is created to generate an API key.

### Generate API Key
Send a POST request to the http://localhost:3000/api/v1/api_keys endpoint with the app_name in the request body. (use your preferred API testing tools like Postman, Curl)

Request header: \
Content-Type: application/json \

Request Body:

```bash
{
    "app_name": "TrustedApp"
}
```

This should return a response with "api_key" and "app_name"

```bash
{
  "api_key": "YOUR_GENERATED_API_KEY",
  "app_name": "TrustedApp"
}
```

#### Save the generated API key as you will need it to authenticate your requests.

### Reservation Endpoint
To create a reservation, send a POST request to the api/v1/reservations endpoint.
Provide a payload with reservation details, including the guest’s information and reservation dates.

Request: \
POST http://localhost:3000/api/v1/reservations \
Content-Type: application/json \
X-API-Key: YOUR_API_KEY

Body:
```bash
{
   "start_date": "2021-03-12",
   "end_date": "2021-03-16",
   "nights": 4,
   "guests": 4,
   "adults": 2,
   "children": 2,
   "infants": 0,
   "status": "accepted",
   "guest": {
      "id": 1,
      "first_name": "Wayne",
      "last_name": "Woodbridge",
      "phone": "639123456789",
      "email": "wayne_woodbridge@bnb.com"
   },
   "currency": "AUD",
   "payout_price": "3800.00",
   "security_price": "500",
   "total_price": "4500.00"
}
```

## Testing
The application uses RSpec for testing.

To run the tests, you can execute the following command:
```bash
bundle exec rspec
```

#### If you have encounter a problem, please contact jhnmike.patay@gmail.com