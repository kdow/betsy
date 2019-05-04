class Seller < ApplicationRecord
  has_many :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.build_from_github(auth_hash)
    seller = Seller.new
    seller.uid = auth_hash[:uid]
    seller.provider = "github"
    seller.username = auth_hash["info"]["name"]
    seller.email = auth_hash["info"]["email"]

    return seller
  end

  def get_order_products
    # products = self.products.map { |product| product.id }
    order_products = []
    self.products.each do |product|
      order_products += OrderProducts.where(product_id: product.id)
    end
    return order_products
  end
end
