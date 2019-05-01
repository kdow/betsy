class Product < ApplicationRecord
  belongs_to :seller
  has_many :order_products

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates_numericality_of :price,
    only_integer: true,
    greater_than: 0
end
