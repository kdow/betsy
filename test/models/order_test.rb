require "test_helper"

describe Order do
  # let(:order) { Order.new }

  # it "must be valid" do
  #   value(order).must_be :valid?
  # end
  describe "validations" do
  end
  describe "relations" do
    it "has a list of order_products" do
      order = orders(:one)
      # order.must_respond_to :OrderProducts
      expect(order.order_products.length).must_equal 2
      order.order_products.each do |product|
        product.must_be_kind_of OrderProduct
      end
    end
    it "can add an order_product through .order_products" do
      order_prod = OrderProduct.new(quantity: 1)
      order_one = orders(:one)
      order_one.order_products << order_prod
      expect(order_one.order_products).must_include order_prod
    end
  end

  describe "calculate total" do
    it "can calculate the total price for the order" do
      order = orders(:one)
      expect(order.calculate_total).must_equal 12000
    end
  end
end
