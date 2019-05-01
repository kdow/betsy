require "test_helper"

describe Order do
  let(:order) { Order.new }

  describe "relations" do
    it "can add an order_product through .order_products" do
      order_prod = OrderProduct.new(quantity: 1)
      order_one = orders(:one)
      order_one.order_products << order_prod
      expect(order_one.order_products).must_include order_prod
    end
  end
end
