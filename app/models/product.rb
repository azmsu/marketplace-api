class Product < ApplicationRecord
  scope :available, -> { where("inventory_count > ?", 0) }

  class << self

    def filter(available)
      return Product.available if available

      Product.all
    end

  end
end
