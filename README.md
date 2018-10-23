# Restorp

#### INTRODUCTION

Restorp is an api that consumers can use to look up restaurants and meals info and then place an order for a choice meal. Customers are also able to track the status of their orders given a ***tracking_id*** or a ***tracking_url***.

### Installation

First, you will need to clone the repository
```
git clone git@github.com:VanPaitin/Restorp.git
```
Then you cd into it

```
cd Restorp
```
Install dependencies: Make sure you have **postgres** instaled on your machine as the development database uses postgres. After this just run bundle install

```
$~ brew install postgres

$~ bundle install
```

Then you setup your database by simply running the following command

```
rails db:setup
```

At this level, you will have your database all populated and the api is ready to consume. Just run:

```
rails server
```
### Usage

Please visit the site [here](https://restorp.herokuapp.com) to read the full documentation and use

### Available Endpoints

The following endpoints are available

| EndPoint                                |   Functionality                      |
| --------------------------------------- | ------------------------------------:|
| POST /users/sign_in                     | Logs a user in                       |
| DELETE /users/sign_out                  | Logs a user out                      |
| POST /orders/                           | Create an order                      |
| PUT /orders/:id                         | Update the status of an order        |
| GET /restaurants/                       | List the restaurants                 |
| GET /meals/                             | Search for meals                     |
| GET /cities/                            | List the available cities            |

### Running the tests

This project is well tested using the RSpec testing framework. To run the tests, simply run the following on your terminal while in the project directory

```
rspec
```

### Versioning
Changes and upgrades are made from time to time in this API. The API is versioned to avoid code breaking. New changes are implemented under a new version. Currently, the Api handles versioning through url name spacing. Simply add ```api/v1/``` to your url to use version 1. To use subsequent versions of the api, just change v1 to v2 or other versions you want.

### Limitations
The API only responds with json, and does not yet have support for xml and other response types.

OAuth not yet implemented.

### API Documentation

The full documentation for the API and the available endpoints is described [here](https://restorp.herokuapp.com)

### Contributing

1. [Fork this repo](https://github.com/VanPaitin/Restorp/fork)

2. Create your feature branch `git checkout -b my-new-feature`

3. Commit your changes `git commit -am 'Add some feature'`

4. Push to the branch `git push origin my-new-feature`

5. Raise a Pull Request
