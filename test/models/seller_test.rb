require "test_helper"

describe Seller do
  let(:seller) { sellers(:sarah) }
  let(:new_seller) { Seller.new }

  it "can add a product through .products" do
    prod = Product.new(name: "mousie", price: 300)
    seller_one = sellers(:kelly)
    seller_one.products << prod
    expect(seller_one.products).must_include prod
  end

  describe "get_unique_orders" do
    it "returns an array of orders " do
      orders = seller.get_unique_orders

      expect(orders).must_be_instance_of Array
      expect(orders.first).must_be_instance_of Order
    end

    it "returns an emply array if there are no orders " do
      expect(new_seller.get_unique_orders).must_equal []
    end
  end
end
