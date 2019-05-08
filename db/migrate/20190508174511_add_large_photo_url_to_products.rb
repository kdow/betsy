class AddLargePhotoUrlToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :large_photo_url, :string
  end
end
