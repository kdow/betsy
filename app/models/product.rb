class Product < ApplicationRecord
  belongs_to :seller
  has_many :order_products
  has_and_belongs_to_many :categories
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
end
