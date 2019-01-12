class ShoppingCartItem < ApplicationRecord
  belongs_to :shopping_cart
  belongs_to :product

  enum state: [:in_cart, :purchased]

  # Checkout this shopping cart item by making a purchase
  def checkout
    self.product.in_cart_count -= self.count
    self.product.purchase(count)
    self.purchased

    self.save!
  end
end
