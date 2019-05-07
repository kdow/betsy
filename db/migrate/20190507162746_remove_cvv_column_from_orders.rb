class RemoveCvvColumnFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :cvv
  end
end
