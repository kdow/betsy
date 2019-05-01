require "test_helper"

describe Order do
  let(:order) { Order.new }

<<<<<<< HEAD
  # it "must be valid" do
  #   value(order).must_be :valid?
  # end
=======
  it "must be valid" do
    value(order).must_be :valid?
  end

  describe "relations" do
    it "can add an order_product through .order_products" do
      order_prod = OrderProduct.new(quantity: 1)
      order_one = orders(:one)
      order_one.order_products << order_prod
      expect(order_one.order_products).must_include order_prod
    end
  end
>>>>>>> 47d88a71b9b97852cfa15d0de5e57cf42c188bb2
end
