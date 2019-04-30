class AddSellerForeignKeyToProducts < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :seller_id
    add_reference :products, :seller, index: true, foreign_key: true
  end
end
