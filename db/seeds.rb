# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.create([
  { title: "Product1", price: 1.45, inventory_count: 1, in_cart_count: 0 },
  { title: "Product2", price: 2.76, inventory_count: 0, in_cart_count: 0 },
  { title: "Product3", price: 0.22, inventory_count: 2, in_cart_count: 0 }
])
