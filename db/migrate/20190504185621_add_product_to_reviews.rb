class AddProductToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :product, index: true
    add_foreign_key :reviews, :products
  end
end
