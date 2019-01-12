class Product < ApplicationRecord
  has_many :shopping_cart_items

  scope :available, -> { where("inventory_count > ?", 0) }

  # Make a purchase of count number of this product
  # @param count [Integer] number of this product to purchase
  def purchase(count = 1)
    self.inventory_count -= count
    self.save!
  end

  # Returns whether count number of this product can be added to a cart
  # @param count [Integer] number of this product to add
  # @return [Boolean]
  def can_be_added_to_cart?(count)
    self.in_cart_count + count <= self.inventory_count
  end

  class << self

    # Applies a filter on products
    # @param available [Boolean] whether to filter on available products
    # @return [ActiveRecord::Relation] all products after filter
    def filter(available)
      return Product.available if available

      Product.all
    end

  end
end
