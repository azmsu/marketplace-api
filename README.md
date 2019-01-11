# README
Marketplace API for the Shopify Summer 2019 Developer Intern Challenge. This API is built using Rails.
The steps involved in making this API are highlighted in `Development Steps` below.

## Getting Started
### Ruby version
`v2.5.1`

### Dependencies
`rails`

`sqlite3`

### Getting started
Make sure the above requirements are met. Clone the repo and run `bundle install`.

### Database setup
```
rake db:create db:migrate db:seed
```
The database seed contains a few products for testing the API.

### Development environment
Run `rails s` to start the API server in your development environment.

You can hit the API at `http://localhost:3000`.

Refer to the API docs in the `API` section below.

## API

### `GET` `/products`
returns JSON response containing list of all products

### `GET` `/products?available=true`
returns JSON response containing list of all products with `inventory_count > 0`

### `GET` `/products/:id`
returns JSON response containing product with id `:id`

## Development Steps

### Basic API for retrieving products

create a new rails api
```
rails new marketplace-api --api
```

generate a `Product` model
```
bin/rails generate model Product
```

creates:
```
db/migrate/20190111130628_create_products.rb
app/models/product.rb
test/models/product_test.rb
```

modify the migration file to create products table with desired columns, and run:
```
rake db:create db:migrate db:seed
```

generate a `Product` controller
```
rails generate controller Products --no-assets
```

creates:
```
app/controllers/products_controller.rb
test/controllers/products_controller_test.rb
```

add routes for `/products` and `/products/:id`

add logic in controller and model for fetching products
