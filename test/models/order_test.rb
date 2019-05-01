require "test_helper"

describe Order do
  # let(:order) { Order.new }

  # it "must be valid" do
  #   value(order).must_be :valid?
  # end
  describe "validations" do
    it "has a list of products" do
      order = orders(:one)
      order.must_respond_to :OrderProducts
      order.products.each do |product|
        product.must_be_kind_of OrderProduct
      end
    end
  end

  describe "relations" do
    it "can add an order_product through .order_products" do
      order_prod = OrderProduct.new(quantity: 1)
      order_one = orders(:one)
      order_one.order_products << order_prod
      expect(order_one.order_products).must_include order_prod
    end
  end
end
