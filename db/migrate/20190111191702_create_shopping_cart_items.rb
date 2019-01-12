class CreateShoppingCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_cart_items do |t|
      t.belongs_to :shopping_cart, index: true
      t.belongs_to :product, index: true
      t.integer :state
      t.integer :count

      t.timestamps
    end
  end
end
