class AddStringCvvToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :cvv, :string
  end
end
