require "test_helper"

describe Order do
  # let(:order) { Order.new }

  # it "must be valid" do
  #   value(order).must_be :valid?
  # end
  describe "relations" do
    it "has a list of order_products" do
      order = orders(:one)
      order.must_respond_to :OrderProducts
      order.orderproducts.each do |product|
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

  describe "validations" do
    it "update the status befor saving the order" do
      order = orders(:one)
      order.status.must_equal nil
      order.save
      expect(order.status).must_equal "In progress"
    end
  end
end
