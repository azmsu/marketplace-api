class AddInCartCountToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :in_cart_count, :integer
  end
end
