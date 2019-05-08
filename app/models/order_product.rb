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

  def self.already_in_cart?(order_product, order)
    result = self.all.where(product_id: order_product.product_id, order_id: order.id)

    if result.empty?
      return false
    else
      return true
    end
  end
end
