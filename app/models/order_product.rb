class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true
  validates_numericality_of :quantity,
                            only_integer: true,
                            greater_than: 0
end
