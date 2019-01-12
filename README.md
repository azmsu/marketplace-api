# README
Marketplace API for the Shopify Summer 2019 Developer Intern Challenge. This API is built using Rails.
The steps involved in making this API are highlighted in `Development Steps` below.

## Getting Started
### Ruby version
`v2.5.1`

### Dependencies
`rails` and `sqlite3`

### Setting up
Make sure the above requirements are met. Clone the repo and run `bundle install`.

### Database
Run `rake db:setup`.

The database seed contains a few products for testing the API.

### Development environment
Run `rails s` to start the API server in your development environment.

You can hit the API at `http://localhost:3000`.

Refer to the API docs in the `API` section below.

## API
Examples shown operate on the database state as shown in `GET /products`.

### `GET` `/products`
Returns JSON response containing list of all products.
```json5
// Status 200 OK
[
    {
        "id": 1,
        "title": "Product1",
        "price": "1.45",
        "inventory_count": 1,
        "in_cart_count": 0
    },
    {
        "id": 2,
        "title": "Product2",
        "price": "2.76",
        "inventory_count": 0,
        "in_cart_count": 0
    },
    {
        "id": 3,
        "title": "Product3",
        "price": "0.22",
        "inventory_count": 2,
        "in_cart_count": 0
    }
]
```

### `GET` `/products?available=true`
Returns JSON response containing list of all products with `inventory_count > 0`.
```json5
// Status 200 OK
[
    {
        "id": 1,
        "title": "Product1",
        "price": "1.45",
        "inventory_count": 1,
        "in_cart_count": 0
    },
    {
        "id": 3,
        "title": "Product3",
        "price": "0.22",
        "inventory_count": 2,
        "in_cart_count": 0
    }
]
```

### `GET` `/products/:id`
Returns JSON response containing product with id, `:id`.
```json5
// GET /products/1
// Status 200 OK
{
    "id": 1,
    "title": "Product1",
    "price": "1.45",
    "inventory_count": 1,
    "in_cart_count": 0
}
```

### `PUT` `products/:id`
Purchases a single instance of product with id, `:id` and responds with the updated product.
```json5
// Body
{ "purchase": true }
```
```json5
// PUT /products/1
// Status 200 OK
{
    "inventory_count": 0,
    "id": 1,
    "title": "Product1",
    "price": "1.45",
    "in_cart_count": 0
}
```
```json5
// PUT /products/2
// Status 404 Not Found
{
    "message": "Couldn't find Product with 'id'=2 [WHERE (inventory_count > 0)]"
}
```

### `POST` `/shopping_carts`
Creates a shopping cart and sends it in the response.
```json5
// Status 201 Created
{
    "id": 1,
    "completed": false,
    "total": "0.0",
    "products": []
}
```
*Note: using shopping cart created above from here on.*

### `GET` `/shopping_carts`
Returns JSON response containing list of all shopping carts.
```json5
// Status 200 OK
[
    {
        "id": 1,
        "completed": false,
        "total": "0.0",
        "products": []
    }
]
```

### `GET` `/shopping_carts/:id`
Returns JSON response containing shopping cart with id, `:id`.
```json5
// GET /shopping_carts/1
// Status 200 OK
{
    "id": 1,
    "completed": false,
    "total": "0.0",
    "products": []
}
```

### `PUT` `/shopping_carts/:id`
Adds `count` number of the product with id, `product_id` to the shopping cart.
```json5
// Body
{
    "item_to_be_added": {
        "product_id": 3,
        "count": 1
    }
}
```
```json5
// PUT /shopping_carts/1
// Status 200 OK
{
    "id": 1,
    "total": "0.22",
    "completed": false,
    "products": [
        {
            "id": 3,
            "title": "Product3",
            "price": "0.22",
            "inventory_count": 2,
            "in_cart_count": 1
        }
    ]
}
```
Checkout (complete) the cart and respond with the cart.
```json5
// Body
{ "checkout": true }
```
```json5
// PUT /shopping_carts/1
// Status 200 OK
{
    "id": 1,
    "completed": true,
    "total": "0.0",
    "products": [
        {
            "id": 3,
            "title": "Product3",
            "price": "0.22",
            "inventory_count": 1,
            "in_cart_count": 0
        }
    ]
}
```

## Development Steps

### Basic API for retrieving products

Create a new Rails API:
```
rails new marketplace-api --api
```

Generate a `Product` model:
```
bin/rails generate model Product
```

This creates:
```
db/migrate/20190111130628_create_products.rb
app/models/product.rb
test/models/product_test.rb
```

Modify the migration file to create products table with desired columns.

Generate a `Products` controller:
```
rails generate controller Products --no-assets
```

This creates:
```
app/controllers/products_controller.rb
test/controllers/products_controller_test.rb
```

Add routes for `/products` and `/products/:id`.

Add logic in controller and model for fetching and purchasing products.

### Adding a basic shopping cart

Generate a `ShoppingCart` and `ShoppingCartItem` model:
```
bin/rails generate model ShoppingCart
bin/rails generate model ShoppingCartItem
```

Generate migration to add `in_cart_count` column to the `products` table:
```
bin/rails generate migration AddInCartCountToProducts
```

Add logic to models to support shopping carts.

Generate controller and add routes for `ShoppingCarts`:
```
bin/rails generate controller ShoppingCarts
```

Add logic to controllers to handle shopping cart creation, adding items, and checking out.

## Next Steps
- Add unit tests using rspec.
- Add more features, like removing items from shopping cart, adding users, ability to create products, etc.
- Make API secure.
