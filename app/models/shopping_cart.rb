class ShoppingCart < ApplicationRecord
  has_many :shopping_cart_items
  has_many :products, through: :shopping_cart_items

  scope :uncompleted, -> { where("completed = ?", false) }

  # Add count number of product to the cart
  # @param product [Product]: the product to add to the cart
  # @param count [Integer]: the number of the product to add
  # @return [Product]: return the product if successful, otherwise return nil
  def add_item(product, count = 1)
    return nil unless product.can_be_added_to_cart?(count)

    # find or initialize the item based on product id
    item = self.shopping_cart_items.find_or_initialize_by(product_id: product.id)
    item.count ||= 0
    item.count += count
    item.in_cart!
    item.save!

    # update the total cost in the shopping cart and in-cart count of the product
    self.total += product.price * count
    self.save!
    product.in_cart_count += count
    product.save!

    product
  end

  # Checkout (complete) the cart
  def checkout
    self.shopping_cart_items.each do |item|
      item.checkout
    end

    self.update_attributes(completed: true, total: 0)
  end
end
