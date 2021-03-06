
class Seller < ApplicationRecord
  has_many :products

  has_many :orders, through: :products
  has_many :order_products, through: :products

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

  def get_unique_orders
    unique_orders = self.orders.uniq { |order| order.id }
    return unique_orders
  end

  def order_revenue(order)
    order_total = 0
    order.order_products.each do |order_product|
      order_total += (order_product.product.price * order_product.quantity) if order_product.product.seller == self
    end
    return order_total
  end

  def total_revenue_by_status(order_status)
    total = 0
    self.get_unique_orders.each do |order|
      total += order_revenue(order) if order.status == order_status
    end
    return total
  end

  def total_items_sold
    order_items = 0
    self.order_products.each do |item|
      if item.order.status == "completed"
        order_items += item.quantity
      end
    end
    return order_items
  end
end
