class Product < ApplicationRecord
  belongs_to :seller
  has_many :order_products
  has_and_belongs_to_many :categories
  has_many :reviews
  has_many :orders, through: :order_products

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates_numericality_of :price,
    only_integer: true,
    greater_than: 0

  def self.adjust_quantity(order_products)
    order_products.each do |item|
      item.product.quantity -= item.quantity
      item.product.save
    end
  end

  def self.check_quantity(order_products)
    order_products.each do |item|
      if item.product.quantity < item.quantity
        return false
      end
    end
    return true
  end

  def self.active(products)
    return products.select { |product| product.is_active != false }
  end

  def self.most_popular
    products = OrderProduct.group(:product_id).count
    ids = products.sort_by {|k,v| v}.reverse.map(&:first)
    where(id: ids)
  end
end
