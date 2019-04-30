class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.integer :quantity
      t.string :photo_url
      t.integer :seller_id

      t.timestamps
    end
  end
end
