class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true
  validates_numericality_of :quantity,
                            only_integer: true,
                            greater_than: 0
                          

  def line_item_subtotal
    return self.quantity * self.product.price
  end
end
