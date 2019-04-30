class AddForeignKeysToOrderProduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_products, :order, index: true, foreign_key: true
    add_reference :order_products, :product, index: true, foreign_key: true
  end
end
