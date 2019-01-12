class CreateShoppingCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_carts do |t|
      t.boolean :completed, default: false, null: false
      t.decimal :total, default: 0, null: false

      t.timestamps
    end
  end
end
