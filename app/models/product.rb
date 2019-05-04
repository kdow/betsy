class Product < ApplicationRecord
  belongs_to :seller
  has_many :order_products
  has_and_belongs_to_many :categories
  has_many :reviews

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates_numericality_of :price,
    only_integer: true,
    greater_than: 0
end
