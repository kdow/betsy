require "test_helper"

describe Order do
  let(:order) { Order.new }

  it "must be valid" do
    value(order).must_be :valid?
  end

  describe "relations" do
    it "can add an order_product through .order_products" do
      order_prod = OrderProduct.new(quantity: 1)
      order_one = order(:one)
      order_one.order_products << order_prod
      expect(product_one.order_products).must_include order_prod
    end
  end
end
