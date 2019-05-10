class AddShippedToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :shipped, :boolean
  end
end
